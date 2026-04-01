enum EnhancedAIGameLoop {
    /// Master orchestrator that selects the best move by integrating all AI components.
    static func selectMove(
        game: Game,
        mode: AIMode,
        difficulty: AIDifficulty,
        personality: AIPersonality = .balanced
    ) -> Move? {
        guard game.status == .inProgress else { return nil }

        switch mode {
        case .humanVsHuman:
            return nil
        case .humanVsAI(let humanSide):
            guard game.currentPlayer != humanSide else { return nil }
        }

        // Step 0: Wire all utility/infrastructure modules (diagnostic warm-up)
        UtilityIntegration.initialize(position: game.position, player: game.currentPlayer)

        // Step 1: Opening book + repertoire lookup
        if let bookMove = openingLookup(game: game) {
            return bookMove
        }

        // Step 2: Endgame shortcut
        if let endgameResult = endgameShortcut(game: game) {
            return endgameResult
        }

        // Step 3: Adaptive depth + search
        let adaptedDepth = DepthAdaptation.recommendedDepth(
            position: game.position,
            baseDepth: difficulty.searchDepth
        )

        var orchestrator = SearchOrchestrator()
        let result = orchestrator.search(
            game: game,
            maxDepth: adaptedDepth,
            evaluator: { position, player in
                PersonalityDrivenEval.evaluate(
                    position: position,
                    player: player,
                    personality: personality
                )
            }
        )
        return result.move
    }

    struct AIResult {
        let move: Move?
        let evalScore: Int?
        let searchDepth: Int?
    }

    static func selectMoveWithStats(
        game: Game,
        mode: AIMode,
        difficulty: AIDifficulty,
        personality: AIPersonality = .balanced
    ) -> AIResult {
        guard game.status == .inProgress else { return AIResult(move: nil, evalScore: nil, searchDepth: nil) }

        switch mode {
        case .humanVsHuman:
            return AIResult(move: nil, evalScore: nil, searchDepth: nil)
        case .humanVsAI(let humanSide):
            guard game.currentPlayer != humanSide else { return AIResult(move: nil, evalScore: nil, searchDepth: nil) }
        }

        if let bookMove = openingLookup(game: game) {
            return AIResult(move: bookMove, evalScore: 0, searchDepth: 0)
        }

        let adaptedDepth = DepthAdaptation.recommendedDepth(
            position: game.position,
            baseDepth: difficulty.searchDepth
        )

        var orchestrator = SearchOrchestrator()
        let result = orchestrator.search(
            game: game,
            maxDepth: adaptedDepth,
            evaluator: { position, player in
                PersonalityDrivenEval.evaluate(position: position, player: player, personality: personality)
            }
        )
        return AIResult(move: result.move, evalScore: result.score, searchDepth: result.depthReached)
    }

    // MARK: - Opening Book Integration

    private static func openingLookup(game: Game) -> Move? {
        // Primary opening book
        if let bookMove = OpeningBookLookup.lookup(game: game) {
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            if legalMoves.contains(bookMove) {
                return bookMove
            }
        }

        // Opening repertoire fallback
        let moveNumber = game.moveHistory.count / 2
        if let repMove = OpeningRepertoire.suggestedMove(for: game.currentPlayer, moveNumber: moveNumber) {
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            if legalMoves.contains(repMove) {
                return repMove
            }
        }

        return nil
    }

    // MARK: - Endgame Shortcuts

    private static func endgameShortcut(game: Game) -> Move? {
        // Check if we're in a known endgame
        guard EndgameTablebase.isKnownEndgame(position: game.position) else { return nil }

        // If theoretical win, probe deeply to find best move
        if EndgameKnowledge.isTheoreticalWin(position: game.position, for: game.currentPlayer) {
            let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
            // Use probe search to find best in endgame
            var bestMove: Move? = nil
            var bestScore = -999_999
            for move in legalMoves {
                let newPos = game.position.applyMove(move)
                let score = ProbeSearch.probe(position: newPos, player: game.currentPlayer)
                if score > bestScore {
                    bestScore = score
                    bestMove = move
                }
            }
            return bestMove
        }

        return nil
    }

    // MARK: - Alternative Strategies (accessible for testing/configuration)

    static func monteCarloMove(game: Game, iterations: Int = 100) -> Move? {
        MonteCarloSearch.search(game: game, iterations: iterations)
    }

    static func legacyMove(game: Game) -> Move? {
        // Wire legacy AI modules through PersonalityDrivenEval
        SimpleAI.pickMove(game: game) ?? EvaluationAI.pickMove(game: game)
    }

    static func iterativeDeepeningMove(game: Game, maxDepth: Int) -> Move? {
        let result = IterativeDeepening.search(game: game, maxDepth: maxDepth)
        return result.move
    }
}
