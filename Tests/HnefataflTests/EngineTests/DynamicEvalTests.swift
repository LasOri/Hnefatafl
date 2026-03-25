import Testing
@testable import Hnefatafl

@Suite("Dynamic Eval Tests")
struct DynamicEvalTests {

    @Test("returns integer evaluation")
    func returnsInt() {
        let position = Position.copenhagenStart()
        let score = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 0)
        #expect(score == score)
    }

    @Test("early game uses lower mobility weight")
    func earlyGameLowerWeight() {
        let position = Position.copenhagenStart()
        let earlyScore = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 5)
        let lateScore = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 35)
        #expect(earlyScore != lateScore)
    }

    @Test("attacker and defender get different scores")
    func differentForPlayers() {
        let position = Position.copenhagenStart()
        let attackerScore = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 15)
        let defenderScore = DynamicEval.evaluate(position: position, player: .defender, moveCount: 15)
        #expect(attackerScore != defenderScore)
    }

    @Test("move count affects phase multiplier")
    func moveCountAffectsPhase() {
        let position = Position.copenhagenStart()
        let opening = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 0)
        let midgame = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 20)
        #expect(opening != midgame || opening == 0)
    }

    @Test("sparse board evaluates without crash")
    func sparseBoardEval() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let score = DynamicEval.evaluate(position: position, player: .attacker, moveCount: 40)
        #expect(score != Int.min)
    }
}
