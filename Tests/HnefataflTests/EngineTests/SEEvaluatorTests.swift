import Testing
@testable import Hnefatafl

@Suite("SEEvaluator Tests")
struct SEEvaluatorTests {

    @Test("empty square evaluates to zero")
    func emptySquareZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(SEEvaluator.evaluate(position: position, targetRow: 5, targetCol: 5) == 0)
    }

    @Test("piece with more attackers adjacent")
    func moreAttackers() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let score = SEEvaluator.evaluate(position: position, targetRow: 5, targetCol: 5)
        #expect(score > 0)
    }

    @Test("piece with more defenders adjacent")
    func moreDefenders() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .placing(.defender, row: 4, col: 5)
            .build()
        let score = SEEvaluator.evaluate(position: position, targetRow: 5, targetCol: 5)
        #expect(score < 0)
    }

    @Test("winning exchange for attacker")
    func winningForAttacker() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        #expect(SEEvaluator.isWinningExchange(position: position, targetRow: 5, targetCol: 5, forPlayer: .attacker))
    }

    @Test("winning exchange for defender")
    func winningForDefender() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .build()
        #expect(SEEvaluator.isWinningExchange(position: position, targetRow: 5, targetCol: 5, forPlayer: .defender))
    }

    @Test("balanced exchange not winning for either")
    func balancedExchange() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .build()
        let score = SEEvaluator.evaluate(position: position, targetRow: 5, targetCol: 5)
        #expect(score == 0)
    }
}
