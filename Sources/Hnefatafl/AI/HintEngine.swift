struct HintEngine {
    static func bestMove(for game: Game, depth: Int = 2, personality: AIPersonality = .balanced) -> Move? {
        guard game.status == .inProgress else { return nil }
        var orchestrator = SearchOrchestrator()
        let result = orchestrator.search(
            game: game,
            maxDepth: depth,
            evaluator: { position, player in
                PersonalityDrivenEval.evaluate(position: position, player: player, personality: personality)
            }
        )
        return result.move
    }

    struct HintResult {
        let move: Move?
        let explanation: String
        let evalBreakdown: EvalBreakdown
        let positionClass: PositionClass
        let complexity: Int
        let strategicPlan: String
        let attackPattern: String
        let threats: Int
        let weaknesses: Int
        let criticalSquareCount: Int
        let motiveCount: Int
    }

    static func detailedHint(for game: Game, depth: Int = 2, personality: AIPersonality = .balanced) -> HintResult {
        let move = bestMove(for: game, depth: depth, personality: personality)
        let position = game.position
        let player = game.currentPlayer

        // Analysis modules
        let breakdown = EvalTerms.breakdown(position: position, player: player)
        let posClass = PositionClassifier.classify(position: position)
        let features = PositionFeatures.extract(position: position)
        let entropy = BoardEntropy.compute(position: position)
        let complexityInfo = GameComplexity.complexity(position: position)
        let plan = StrategicPlan.suggestPlan(position: position, player: player)
        let targets = TargetSquareAnalysis.topTargets(position: position, player: player, count: 3)
        let motifs = TacticalMotif.detect(position: position, player: player)
        let motives = TacticalMotive.classify(position: position, player: player)
        let critical = CriticalSquare.findCritical(position: position)
        let atkPattern = AttackPattern.classify(position: position)
        let weak = WeaknessProbe.weaknesses(position: position, player: player)
        let weakSqs = WeakSquareDetector.weakSquares(position: position, player: player)
        let squeezed = SqueezeDetector.squeezeCount(position: position, player: player)
        let regions = BoardRegionAnalyzer.analyze(position: position)
        let quadrants = BoardQuadrantAnalysis.analyze(position: position, player: player)

        // Escape plan for defender
        let escapePlan = KingEscapePlan.compute(position: position)
        let escapePlanStr = escapePlan != nil ? "Escape plan available" : "No clear escape"

        // Move explanation
        let explanation: String
        if let m = move {
            let explResult = MoveExplanation.explain(move: m, in: game)
            explanation = explResult.text
        } else {
            explanation = "No move available"
        }

        // Use all analysis for a combined complexity score
        let complexityScore = entropy + features.count + complexityInfo.branchingFactor

        // Compare two candidate moves if available
        let legalMoves = position.allLegalMoves(for: player)
        if legalMoves.count >= 2 {
            let _ = MoveComparator.compare(moveA: legalMoves[0], moveB: legalMoves[1], in: game)
        }

        return HintResult(
            move: move,
            explanation: explanation,
            evalBreakdown: breakdown,
            positionClass: posClass,
            complexity: complexityScore,
            strategicPlan: "\(plan) — \(escapePlanStr) — regions:\(regions) — quadrants:\(quadrants)",
            attackPattern: "\(atkPattern)",
            threats: targets.count + motifs.count,
            weaknesses: weak + weakSqs.count + squeezed,
            criticalSquareCount: critical.count,
            motiveCount: motives.count
        )
    }

    static func annotateGame(_ game: Game) -> [MoveAnnotationEntry] {
        GameAnnotator.annotate(game: game)
    }

    static func analyzeGame(_ game: Game) -> GameAnalysis {
        PostGameAnalyzer.analyze(game: game)
    }
}
