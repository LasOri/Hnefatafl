import Testing
@testable import Hnefatafl

@Suite("Double Attack Eval Tests")
struct DoubleAttackEvalTests {

    @Test("empty board has no double attacks")
    func emptyBoardNoDoubleAttacks() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(DoubleAttackEval.evaluate(position: pos) == 0)
    }

    @Test("hasDoubleAttack returns false on empty board")
    func noDoubleAttackEmpty() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(!DoubleAttackEval.hasDoubleAttack(position: pos))
    }

    @Test("start position evaluates without crash")
    func startPositionEvaluates() {
        let pos = Position.copenhagenStart()
        let score = DoubleAttackEval.evaluate(position: pos)
        #expect(score >= 0)
    }

    @Test("hasDoubleAttack consistent with evaluate")
    func consistencyCheck() {
        let pos = Position.copenhagenStart()
        let score = DoubleAttackEval.evaluate(position: pos)
        #expect(DoubleAttackEval.hasDoubleAttack(position: pos) == (score > 0))
    }

    @Test("setup with potential double attack threat")
    func potentialDoubleAttack() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .placing(.defender, row: 3, col: 5)
            .placing(.attacker, row: 2, col: 3)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 3, col: 7)
            .build()
        let score = DoubleAttackEval.evaluate(position: pos)
        #expect(score >= 0)
    }

    @Test("single attacker no double attack")
    func singleAttackerNoDouble() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .build()
        #expect(DoubleAttackEval.evaluate(position: pos) == 0)
    }
}
