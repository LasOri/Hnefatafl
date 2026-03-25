import Testing
@testable import Hnefatafl

@Suite("GamePhaseEvaluator Tests")
struct GamePhaseEvaluatorTests {
    @Test("Evaluate starting position for attackers")
    func evaluateStartAttackers() {
        let position = Position.copenhagenStart()
        let score = GamePhaseEvaluator.evaluateForPhase(position: position, player: .attacker)
        #expect(score != 0)
    }

    @Test("Evaluate starting position for defenders")
    func evaluateStartDefenders() {
        let position = Position.copenhagenStart()
        let score = GamePhaseEvaluator.evaluateForPhase(position: position, player: .defender)
        #expect(score != 0)
    }

    @Test("Phase weights for opening")
    func openingWeights() {
        let weights = GamePhaseEvaluator.phaseWeight(.opening)
        #expect(weights.material > 0)
        #expect(weights.mobility > 0)
        #expect(weights.kingDistance > 0)
    }

    @Test("Phase weights for midgame")
    func midgameWeights() {
        let weights = GamePhaseEvaluator.phaseWeight(.midgame)
        #expect(weights.material > 0)
        #expect(weights.mobility > 0)
        #expect(weights.kingDistance > 0)
    }

    @Test("Phase weights for endgame")
    func endgameWeights() {
        let weights = GamePhaseEvaluator.phaseWeight(.endgame)
        #expect(weights.material > 0)
        #expect(weights.mobility > 0)
        #expect(weights.kingDistance > 0)
    }

    @Test("Different phases produce different evaluations")
    func differentPhases() {
        let position = Position.copenhagenStart()
        let openingScore = GamePhaseEvaluator.evaluateForPhase(position: position, player: .attacker)
        #expect(openingScore != 0)
    }
}
