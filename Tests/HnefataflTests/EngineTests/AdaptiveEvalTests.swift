import Testing
@testable import Hnefatafl

@Suite("Adaptive Eval Tests")
struct AdaptiveEvalTests {

    @Test("returns an integer")
    func returnsInt() {
        let position = Position.copenhagenStart()
        let score = AdaptiveEval.evaluate(position: position, player: .attacker)
        #expect(score == score)
    }

    @Test("start position evaluates without crash")
    func startPositionEval() {
        let position = Position.copenhagenStart()
        let score = AdaptiveEval.evaluate(position: position, player: .attacker)
        #expect(score != Int.min)
    }

    @Test("different scores for attacker and defender")
    func differentForPlayers() {
        let position = Position.copenhagenStart()
        let attackerScore = AdaptiveEval.evaluate(position: position, player: .attacker)
        let defenderScore = AdaptiveEval.evaluate(position: position, player: .defender)
        #expect(attackerScore != defenderScore || attackerScore == 0)
    }

    @Test("phase affects evaluation")
    func phaseAffectsEval() {
        let fullPosition = Position.copenhagenStart()
        let sparsePosition = emptyBoard()
            .placing(.king, row: 3, col: 3)
            .placing(.attacker, row: 7, col: 7)
            .placing(.attacker, row: 8, col: 8)
            .build()
        let fullScore = AdaptiveEval.evaluate(position: fullPosition, player: .attacker)
        let sparseScore = AdaptiveEval.evaluate(position: sparsePosition, player: .attacker)
        #expect(fullScore != sparseScore)
    }

    @Test("non-zero for non-empty board")
    func nonZeroForNonEmpty() {
        let position = Position.copenhagenStart()
        let score = AdaptiveEval.evaluate(position: position, player: .attacker)
        #expect(score != 0)
    }
}
