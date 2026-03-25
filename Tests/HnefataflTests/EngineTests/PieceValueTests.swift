import Testing
@testable import Hnefatafl

@Suite("Piece Value Tests")
struct PieceValueTests {

    @Test("attacker value is 100")
    func attackerValue() {
        #expect(PieceValue.value(piece: .attacker) == 100)
    }

    @Test("defender value is 150")
    func defenderValue() {
        #expect(PieceValue.value(piece: .defender) == 150)
    }

    @Test("king value is 10000")
    func kingValue() {
        #expect(PieceValue.value(piece: .king) == 10000)
    }

    @Test("total attacker value at start")
    func totalAttackerStart() {
        let position = Position.copenhagenStart()
        let total = PieceValue.totalValue(position: position, player: .attacker)
        #expect(total == position.attackerCount * 100)
    }

    @Test("total defender value includes king")
    func totalDefenderIncludesKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let total = PieceValue.totalValue(position: position, player: .defender)
        #expect(total == 10000 + 150)
    }
}
