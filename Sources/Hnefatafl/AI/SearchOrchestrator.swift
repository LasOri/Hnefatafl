struct OrchestratedSearchResult: Equatable {
    let move: Move?
    let score: Int
    let depthReached: Int
}

struct SearchOrchestrator {
    var tt: TranspositionTable
    var killers: KillerMoveTable
    var history: HistoryTable
    var budget: SearchBudget
    var nodeCounter: NodeCounter
    var repetitionDetector: RepetitionDetector

    init(ttSize: Int = 10000) {
        self.tt = TranspositionTable(maxSize: ttSize)
        self.killers = KillerMoveTable()
        self.history = HistoryTable()
        self.budget = SearchBudget(maxNodes: 500_000)
        self.nodeCounter = NodeCounter()
        self.repetitionDetector = RepetitionDetector()
    }

    mutating func search(
        game: Game,
        maxDepth: Int,
        evaluator: (Position, Player) -> Int
    ) -> OrchestratedSearchResult {
        // Terminal position check
        guard game.status == .inProgress else {
            let score = evaluator(game.position, game.currentPlayer)
            return OrchestratedSearchResult(move: nil, score: score, depthReached: 0)
        }

        // Depth 0: return static evaluation only
        guard maxDepth >= 1 else {
            let score = evaluator(game.position, game.currentPlayer)
            return OrchestratedSearchResult(move: nil, score: score, depthReached: 0)
        }

        // Record root position for repetition detection
        repetitionDetector.record(position: game.position)

        var bestMove: Move? = nil
        var bestScore = 0
        var depthReached = 0
        var pvMove: Move? = nil

        // Iterative deepening loop with aspiration windows
        for depth in 1...maxDepth {
            guard !budget.isExhausted else { break }

            let moves = game.position.allLegalMoves(for: game.currentPlayer)
            guard !moves.isEmpty else { break }

            let orderedMoves = MoveOrderingPipeline.order(
                moves: moves,
                position: game.position,
                player: game.currentPlayer,
                killers: killers,
                history: history,
                depth: depth,
                pvMove: pvMove
            )

            // Aspiration window: use previous score if available
            var searchAlpha: Int
            var searchBeta: Int
            if depth > 1 {
                let window = AspirationWindow(previousScore: bestScore)
                searchAlpha = window.alpha
                searchBeta = window.beta
            } else {
                searchAlpha = -999_999
                searchBeta = 999_999
            }

            var currentBest = orderedMoves[0]
            var currentBestScore = -999_999

            for move in orderedMoves {
                guard !budget.isExhausted else { break }
                let newGame = game.makeMove(move)
                let score = -negamax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: -searchBeta,
                    beta: -searchAlpha,
                    evaluator: evaluator
                )
                if score > currentBestScore {
                    currentBestScore = score
                    currentBest = move
                }
                if score > searchAlpha {
                    searchAlpha = score
                }
            }

            // If aspiration window failed (score outside), re-search with full window
            if depth > 1 && (currentBestScore <= bestScore - AspirationWindow.defaultSize || currentBestScore >= bestScore + AspirationWindow.defaultSize) {
                searchAlpha = -999_999
                searchBeta = 999_999
                currentBestScore = -999_999
                for move in orderedMoves {
                    guard !budget.isExhausted else { break }
                    let newGame = game.makeMove(move)
                    let score = -negamax(
                        game: newGame,
                        depth: depth - 1,
                        alpha: -searchBeta,
                        beta: -searchAlpha,
                        evaluator: evaluator
                    )
                    if score > currentBestScore {
                        currentBestScore = score
                        currentBest = move
                    }
                    if score > searchAlpha {
                        searchAlpha = score
                    }
                }
            }

            bestMove = currentBest
            bestScore = currentBestScore
            depthReached = depth
            pvMove = currentBest
        }

        return OrchestratedSearchResult(
            move: bestMove,
            score: bestScore,
            depthReached: depthReached
        )
    }

    private mutating func negamax(
        game: Game,
        depth: Int,
        alpha: Int,
        beta: Int,
        evaluator: (Position, Player) -> Int
    ) -> Int {
        budget.consume()
        nodeCounter.recordInterior()

        let hash = ZobristHash.hash(position: game.position)

        // TT lookup
        if let entry = tt.lookup(hash: hash), entry.depth >= depth {
            switch entry.flag {
            case .exact:
                return entry.score
            case .lowerBound:
                if entry.score >= beta { return entry.score }
            case .upperBound:
                if entry.score <= alpha { return entry.score }
            }
        }

        // Repetition detection
        if repetitionDetector.count(for: game.position) >= 2 {
            return 0 // Draw by repetition
        }

        // Terminal or leaf node
        if game.status != .inProgress {
            let score = evaluator(game.position, game.currentPlayer)
            tt.store(hash: hash, depth: depth, score: score, flag: .exact)
            return score
        }

        if depth <= 0 {
            nodeCounter.recordLeaf()
            let score = QuiescenceSearch.search(
                position: game.position,
                player: game.currentPlayer,
                alpha: alpha,
                beta: beta,
                evaluator: evaluator
            )
            tt.store(hash: hash, depth: 0, score: score, flag: .exact)
            return score
        }

        // Futility pruning at shallow depths
        if depth <= 2 {
            let staticEval = evaluator(game.position, game.currentPlayer)
            if FutilityPruning.shouldPrune(staticEval: staticEval, alpha: alpha, depth: depth) {
                return staticEval
            }
        }

        // Null move pruning at sufficient depth
        if depth >= 3 && NullMovePruning.shouldAttempt(depth: depth, inCheck: false) {
            let reduction = NullMovePruning.reduction(depth: depth)
            let nullScore = -negamax(
                game: game,
                depth: depth - 1 - reduction,
                alpha: -beta,
                beta: -beta + 1,
                evaluator: evaluator
            )
            if nullScore >= beta {
                return nullScore
            }
        }

        let moves = game.position.allLegalMoves(for: game.currentPlayer)
        if moves.isEmpty {
            let score = evaluator(game.position, game.currentPlayer)
            tt.store(hash: hash, depth: depth, score: score, flag: .exact)
            return score
        }

        let orderedMoves = MoveOrderingPipeline.order(
            moves: moves,
            position: game.position,
            player: game.currentPlayer,
            killers: killers,
            history: history,
            depth: depth,
            pvMove: nil
        )

        var currentAlpha = alpha
        var bestScore = -999_999
        var bestMove = orderedMoves[0]
        var cutoffCount = 0

        for (moveIndex, move) in orderedMoves.enumerated() {
            guard !budget.isExhausted else { break }

            // Multi-cut pruning
            if MultiCutPruning.shouldPrune(cutoffCount: cutoffCount) {
                break
            }

            let newGame = game.makeMove(move)
            repetitionDetector.record(position: newGame.position)

            // Late move reduction
            var searchDepth = depth - 1
            let isCapture = newGame.position.attackerCount + newGame.position.defenderCount
                          < game.position.attackerCount + game.position.defenderCount
            if LateMoveReduction.shouldReduce(moveIndex: moveIndex, depth: depth, isCapture: isCapture) {
                searchDepth -= LateMoveReduction.reduction(moveIndex: moveIndex, depth: depth)
                if searchDepth < 0 { searchDepth = 0 }
            }

            let score = -negamax(
                game: newGame,
                depth: searchDepth,
                alpha: -beta,
                beta: -currentAlpha,
                evaluator: evaluator
            )

            // Re-search at full depth if LMR reduced search found a better score
            if searchDepth < depth - 1 && score > currentAlpha {
                let fullScore = -negamax(
                    game: newGame,
                    depth: depth - 1,
                    alpha: -beta,
                    beta: -currentAlpha,
                    evaluator: evaluator
                )
                if fullScore > bestScore {
                    bestScore = fullScore
                    bestMove = move
                }
                if fullScore > currentAlpha {
                    currentAlpha = fullScore
                }
            } else {
                if score > bestScore {
                    bestScore = score
                    bestMove = move
                }
                if score > currentAlpha {
                    currentAlpha = score
                }
            }

            if currentAlpha >= beta {
                cutoffCount += 1
                killers.store(move: move, at: depth)
                history.record(move: move, depth: depth)
                tt.store(hash: hash, depth: depth, score: bestScore, flag: .lowerBound)
                return bestScore
            }
        }

        let flag: TTFlag
        if bestScore <= alpha {
            flag = .upperBound
        } else {
            flag = .exact
        }
        history.record(move: bestMove, depth: depth)
        tt.store(hash: hash, depth: depth, score: bestScore, flag: flag)
        return bestScore
    }
}
