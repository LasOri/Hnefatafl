import Testing
@testable import Hnefatafl

@Suite("Evaluation Pipeline Tests")
struct EvaluationPipelineTests {

    @Test("pipeline returns integer evaluation for start position")
    func startPositionReturnsInteger() {
        let position = Position.copenhagenStart()
        let weights = EvalWeights()
        let score = EvaluationPipeline.evaluate(position: position, player: .defender, weights: weights)
        #expect(score != 0 || score == 0) // always returns an Int
        // The start position should produce some finite value
        #expect(score > -100_000 && score < 100_000)
    }

    @Test("pipeline scores king near corner higher for defender")
    func kingNearCornerHigherForDefender() {
        let weights = EvalWeights()

        // King near corner (0,1) — 1 step from corner
        let nearCorner = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.defender, row: 5, col: 5)
            .placing(.attacker, row: 10, col: 5)
            .build()

        // King in center (5,5)
        let inCenter = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .placing(.attacker, row: 10, col: 5)
            .build()

        let scoreNear = EvaluationPipeline.evaluate(position: nearCorner, player: .defender, weights: weights)
        let scoreCenter = EvaluationPipeline.evaluate(position: inCenter, player: .defender, weights: weights)

        #expect(scoreNear > scoreCenter)
    }

    @Test("pipeline uses EvalWeights to combine factors")
    func usesEvalWeightsToCombine() {
        let position = Position.copenhagenStart()
        let weights = EvalWeights(material: 100, mobility: 0, kingSafety: 0, territory: 0, position: 0)
        let score = EvaluationPipeline.evaluate(position: position, player: .defender, weights: weights)
        // With only material weight, weighted score is materialDiff * 100, plus formation bonuses
        let materialDiff = position.defenderCount - position.attackerCount
        let materialComponent = materialDiff * 100
        // Score should be dominated by material component; formation bonuses are small relative adjustments
        #expect(abs(score - materialComponent) < 200)
    }

    @Test("pipeline returns different scores for different weights")
    func differentWeightsDifferentScores() {
        let position = Position.copenhagenStart()
        let aggressive = EvalWeights.aggressive
        let defensive = EvalWeights.defensive
        let scoreAggressive = EvaluationPipeline.evaluate(position: position, player: .defender, weights: aggressive)
        let scoreDefensive = EvaluationPipeline.evaluate(position: position, player: .defender, weights: defensive)
        #expect(scoreAggressive != scoreDefensive)
    }

    @Test("pipeline handles empty board gracefully")
    func emptyBoardGraceful() {
        let position = emptyBoard().build()
        let weights = EvalWeights()
        let score = EvaluationPipeline.evaluate(position: position, player: .defender, weights: weights)
        #expect(score == 0)
    }

    @Test("pipeline evaluates for attacker and defender symmetrically by negation")
    func attackerDefenderNegate() {
        let position = Position.copenhagenStart()
        let weights = EvalWeights()
        let defenderScore = EvaluationPipeline.evaluate(position: position, player: .defender, weights: weights)
        let attackerScore = EvaluationPipeline.evaluate(position: position, player: .attacker, weights: weights)
        #expect(attackerScore == -defenderScore)
    }
}
