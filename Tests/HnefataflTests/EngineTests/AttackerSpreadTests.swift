import Testing
@testable import Hnefatafl

@Suite("Attacker Spread Tests")
struct AttackerSpreadTests {

    @Test("start position has nonzero variance")
    func startPositionVariance() {
        let pos = Position.copenhagenStart()
        let v = AttackerSpread.variance(position: pos)
        #expect(v > 0)
    }

    @Test("empty board returns zero")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let v = AttackerSpread.variance(position: pos)
        #expect(v == 0)
    }

    @Test("single attacker has zero variance")
    func singleAttackerZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let v = AttackerSpread.variance(position: pos)
        #expect(v == 0)
    }

    @Test("spread attackers have higher variance than concentrated")
    func spreadVsConcentrated() {
        var spreadCells: [Piece?] = Array(repeating: nil, count: 121)
        spreadCells[0] = .attacker
        spreadCells[10] = .attacker
        spreadCells[110] = .attacker
        spreadCells[120] = .attacker
        let spreadPos = Position(cells: spreadCells)

        var concCells: [Piece?] = Array(repeating: nil, count: 121)
        concCells[5 * 11 + 5] = .attacker
        concCells[5 * 11 + 6] = .attacker
        concCells[6 * 11 + 5] = .attacker
        concCells[6 * 11 + 6] = .attacker
        let concPos = Position(cells: concCells)

        #expect(AttackerSpread.variance(position: spreadPos) > AttackerSpread.variance(position: concPos))
    }

    @Test("isConcentrated check works")
    func isConcentratedCheck() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        #expect(AttackerSpread.isConcentrated(position: pos))
    }
}
