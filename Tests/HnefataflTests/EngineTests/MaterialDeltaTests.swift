import Testing
@testable import Hnefatafl

@Suite("Material Delta Tests")
struct MaterialDeltaTests {

    @Test("empty board has zero raw balance")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(MaterialDelta.rawBalance(position: pos) == 0)
    }

    @Test("start position raw balance favors attackers")
    func startPositionAttackerAdvantage() {
        let pos = Position.copenhagenStart()
        #expect(MaterialDelta.rawBalance(position: pos) > 0)
    }

    @Test("weighted balance counts king as 3")
    func weightedKingValue() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        cells[2] = .attacker
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(MaterialDelta.rawBalance(position: pos) == 2)
        #expect(MaterialDelta.weightedBalance(position: pos) == 0)
    }

    @Test("only attackers gives positive balance")
    func onlyAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        let pos = Position(cells: cells)
        #expect(MaterialDelta.rawBalance(position: pos) == 2)
        #expect(MaterialDelta.weightedBalance(position: pos) == 2)
    }

    @Test("only defenders gives negative balance")
    func onlyDefenders() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .defender
        cells[1] = .defender
        let pos = Position(cells: cells)
        #expect(MaterialDelta.rawBalance(position: pos) == -2)
    }

    @Test("weighted balance more negative than raw when king present")
    func weightedMoreNegative() {
        let pos = Position.copenhagenStart()
        #expect(MaterialDelta.weightedBalance(position: pos) < MaterialDelta.rawBalance(position: pos))
    }
}
