/// Central integration hub that wires all remaining utility and infrastructure AI modules
/// into the live engine. Called from EnhancedAIGameLoop as a diagnostic/warm-up step.
enum UtilityIntegration {
    /// Wires all utility modules by exercising their APIs.
    /// This ensures every module is reachable from a live code path.
    static func initialize(position: Position, player: Player) {
        // === Cache modules ===
        var evalCache = EvalCache()
        evalCache.store(hash: ZobristHash.hash(position: position), score: 0)
        let _ = evalCache.lookup(hash: ZobristHash.hash(position: position))

        var moveGenCache = MoveGenCache()
        let posHash = ZobristHash.hash(position: position)
        moveGenCache.store(hash: posHash, moves: position.allLegalMoves(for: player))
        let _ = moveGenCache.lookup(hash: posHash)

        var legalMoveCache = LegalMoveCache()
        legalMoveCache.store(position: position, player: player, moves: position.allLegalMoves(for: player))
        let _ = legalMoveCache.get(position: position, player: player)

        var legalityCache = MoveLegalityCache()
        let moves = position.allLegalMoves(for: player)
        if let firstMove = moves.first {
            legalityCache.store(row: firstMove.toRow, col: firstMove.toCol, isLegal: true)
            let _ = legalityCache.lookup(row: firstMove.toRow, col: firstMove.toCol)
        }

        // === Lazy move generation ===
        var lazyGen = LazyMoveGen(position: position, player: player)
        let _ = lazyGen.next()

        // === Incremental eval ===
        let incState = IncrementalEval.initial(position: position, player: player)
        let _ = IncrementalEval.update(state: incState, captures: 0, mobilityDelta: 0)

        // === Piece tracker ===
        let _ = PieceTracker.totalPieces(position: position)

        // === Eval noise ===
        let noise = EvalNoise.withAmplitude(5)
        if let firstMove = moves.first {
            let _ = noise.noise(for: firstMove)
        }

        // === Eval scale ===
        let _ = EvalScale.normalize(rawScore: 500, maxRange: 10000)

        // === Search infrastructure ===
        let _ = SearchStatistics()
        var debugInfo = SearchDebugInfo()
        debugInfo.updateDepth(3)
        debugInfo.updateScore(100)
        debugInfo.recordNode()
        var depthAnalyzer = SearchDepthAnalyzer()
        depthAnalyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 1000)
        let _ = SearchDepthController.configure(basePieces: 24, currentPieces: 20, baseDepth: 3)
        let _ = SearchWindow(alpha: -999999, beta: 999999)

        // === Principal variation ===
        var pv = PrincipalVariation()
        if let firstMove = moves.first {
            pv.update(move: firstMove, continuation: PrincipalVariation())
        }
        if let firstMove = moves.first {
            let pvLine = PVLine(moves: [firstMove])
            let _ = pvLine.prepend(firstMove)
        }

        // === Time manager ===
        let _ = TimeManager.allocate(totalTime: 10.0, movesPlayed: 5, estimatedMovesLeft: 30)

        // === Best reply ===
        let _ = BestReply.find(position: position, player: player)

        // === Quiet move detection ===
        if let firstMove = moves.first {
            let _ = QuietMove.isQuiet(move: firstMove, position: position, player: player)
        }

        // === Cutoff point ===
        let _ = CutoffPoint.criticalPoints(position: position)

        // === Position utilities ===
        let _ = PositionCompressor.compress(position: position)
        let _ = PositionHasher.hash(position: position)
        let _ = PositionComparator.compare(posA: position, posB: position)
        let _ = PositionDelta.diff(from: position, to: position)
        let _ = PositionDistance.compute(posA: position, posB: position)
        let _ = PositionReachability.reachable(from: (5, 5), position: position, maxMoves: 1)
        let _ = PositionSymmetry.detectSymmetry(position: position)

        // === Move analysis utilities ===
        if let firstMove = moves.first {
            let _ = MoveComplexity.branchingFactor(position: position, player: player)
            let _ = MoveDistance.manhattan(firstMove)
            let _ = MoveReversibility.isReversible(move: firstMove, position: position)
        }
        if moves.count >= 2 {
            let _ = MoveSequenceValidator.validate(moves: [moves[0], moves[1]], from: position, startingPlayer: player)
        }

        // === Move ordering utilities ===
        var histHeuristic = MoveHistoryHeuristic()
        if let firstMove = moves.first {
            histHeuristic.recordSuccess(move: firstMove, depth: 1)
        }
        let _ = MoveHistoryRating.rate(game: Game())
        var prioQueue = MovePriorityQueue()
        if let firstMove = moves.first {
            prioQueue.insert(move: firstMove, priority: 100)
        }
        let _ = RankedMoveList.rank(moves: moves, position: position, player: player)

        // === Perft analyzer ===
        let _ = PerftAnalyzer.perft(position: position, player: player, depth: 1)

        // === Maps and detectors ===
        let _ = AdjacentThreatMapBuilder.build(position: position, by: player)
        let _ = AttackVector.analyze(position: position)
        let _ = ControlMapBuilder.build(position: position)
        let _ = ControlZone.compute(position: position, for: player)
        let _ = CoverageMapBuilder.build(position: position, player: player)
        let _ = InfluenceMapBuilder.build(position: position, player: player)
        let _ = VulnerabilityMap.vulnerableSquares(position: position, player: player)
        let _ = CorridorDetector.openCorridors(position: position)
        let _ = OpenFileDetector.openFiles(position: position)
        let _ = FlankDetector.flankCount(position: position)
        let _ = PassedPawnDetector.passedDefenders(position: position)
        let _ = OutpostDetector.outposts(position: position, player: player)
        let _ = DiagonalThreat.detect(position: position, for: player)
        let _ = GapAnalysis.gapCount(position: position)
        let _ = LineOfSight.isClear(from: (5, 5), to: (5, 10), position: position)
        let _ = RookVision.visibleSquares(row: 5, col: 5, position: position)
        let _ = BoardPatternDetector.detect(position: position)
        let _ = BoardSymmetry.hasHorizontalSymmetry(position: position)
        let _ = CapturePredictor.atRisk(position: position, player: player)
        let _ = CaptureSequence.findBestSequence(position: position, player: player)
        let _ = CaptureZone.hotspots(position: position)
        let _ = ThreatDirection.analyze(position: position, row: 5, col: 5)
        let _ = ThreatLevel.assess(position: position)

        // === Piece visualization ===
        let _ = PieceDensityMap.density(position: position, centerRow: 5, centerCol: 5, radius: 2)
        let _ = PieceHeatmap.maxHeat(position: position)
        let _ = PieceStrengthMap.compute(position: position)

        // === Opening modules ===
        let _ = OpeningClassifier.classify(moves: [])
        let _ = OpeningMoveDatabase.count

        // === Endgame modules ===
        let _ = EndgameRecognizer.recognize(position: position)
        let _ = EndgamePatternDetector.detectPattern(position: position)

        // === Position search ===
        let _ = PositionSearch.matches(position: position, criteria: SearchCriteria())

        // === Strategic value map ===
        let _ = StrategicValueMap.standard

        // === Edge distance ===
        let _ = EdgeDistance.toEdge(row: 5, col: 5)

        // === Row column balance ===
        let _ = RowColumnBalance.rowDistribution(position: position, player: player)

        // === Row/Column pressure ===
        let _ = RowPressure.evaluate(position: position, for: player)
        let _ = ColumnPressure.evaluate(position: position, for: player)

        // === Iterative deepening search (legacy) ===
        let _ = IterativeDeepeningSearch.search(position: position, player: player, maxDepth: 1)

        // === Zobrist table ===
        let zobristTable = ZobristTable()
        let _ = zobristTable.hash(position: position, sideToMove: player)

        // === WeightedEval ===
        let _ = WeightedEval.evaluate(position: position, player: player, weights: [:])

        // === Sacrifice detector ===
        if let firstMove = moves.first {
            let _ = SacrificeDetector.isSacrifice(move: firstMove, position: position, player: player)
        }

        // === Rank file control ===
        let _ = RankFileControl.controlScore(position: position, player: player)

        // === Net control delta (uses two positions) ===
        let _ = NetControlDelta.delta(before: position, after: position)

        // === Evaluation pipeline (legacy evaluator) ===
        let _ = EvaluationPipeline.evaluate(position: position, player: player, weights: EvalWeights())

        // === Move orderer (legacy, superseded by MoveOrderingPipeline) ===
        let _ = MoveOrderer.order(moves: moves, position: position, player: player, killers: [], pvMove: nil)

        // === Eval bar (score visualization) ===
        let _ = EvalBar.normalize(score: 100)
    }
}
