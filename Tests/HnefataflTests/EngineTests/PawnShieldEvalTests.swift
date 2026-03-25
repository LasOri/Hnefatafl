import Testing
@testable import Hnefatafl

@Suite("Pawn Shield Eval Tests")
struct PawnShieldEvalTests {

    @Test("no king returns zero")
    func noKingZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PawnShieldEval.evaluate(position: position) == 0)
    }

    @Test("shield count at starting position")
    func shieldCountAtStart() {
        let position = Position.copenhagenStart()
        let count = PawnShieldEval.shieldCount(position: position)
        #expect(count == 4)
    }

    @Test("king alone has zero shield count")
    func kingAloneZeroShield() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        #expect(PawnShieldEval.shieldCount(position: position) == 0)
    }

    @Test("evaluate is higher with more defenders adjacent")
    func moreDefendersHigherEval() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[3 * 11 + 3] = .king
        cells1[3 * 11 + 4] = .defender
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[3 * 11 + 3] = .king
        cells2[3 * 11 + 4] = .defender
        cells2[3 * 11 + 2] = .defender
        let pos2 = Position(cells: cells2)

        #expect(PawnShieldEval.evaluate(position: pos2) >= PawnShieldEval.evaluate(position: pos1))
    }

    @Test("attackers adjacent reduce eval")
    func attackersReduceEval() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[3 * 11 + 3] = .king
        cells1[3 * 11 + 4] = .defender
        cells1[3 * 11 + 2] = .defender
        let posNoAttacker = Position(cells: cells1)

        var cells2 = cells1
        cells2[4 * 11 + 3] = .attacker
        let posWithAttacker = Position(cells: cells2)

        #expect(PawnShieldEval.evaluate(position: posNoAttacker) >= PawnShieldEval.evaluate(position: posWithAttacker))
    }

    @Test("shield count with no king is zero")
    func shieldCountNoKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        #expect(PawnShieldEval.shieldCount(position: position) == 0)
    }

    @Test("evaluate never returns negative")
    func evaluateNonNegative() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(PawnShieldEval.evaluate(position: position) >= 0)
    }
}
