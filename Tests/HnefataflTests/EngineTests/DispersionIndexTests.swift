import Testing
@testable import Hnefatafl

@Suite("DispersionIndex Tests")
struct DispersionIndexTests {

    @Test("empty board returns zero dispersion")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(DispersionIndex.index(position: position, player: .attacker) == 0)
    }

    @Test("single piece returns zero dispersion")
    func singlePieceZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(DispersionIndex.index(position: position, player: .attacker) == 0)
    }

    @Test("adjacent pieces have small dispersion")
    func adjacentSmallDispersion() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        let d = DispersionIndex.index(position: position, player: .attacker)
        #expect(d > 0 && d < 2)
    }

    @Test("corner pieces have high dispersion")
    func cornerHighDispersion() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[10] = .attacker
        cells[110] = .attacker
        cells[120] = .attacker
        let position = Position(cells: cells)
        let d = DispersionIndex.index(position: position, player: .attacker)
        #expect(d > 5)
    }

    @Test("isCompact is true for adjacent pieces")
    func isCompactAdjacent() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(DispersionIndex.isCompact(position: position, player: .attacker) == true)
    }

    @Test("start position has measurable defender dispersion")
    func startPositionDefenders() {
        let position = Position.copenhagenStart()
        let d = DispersionIndex.index(position: position, player: .defender)
        #expect(d > 0)
    }
}
