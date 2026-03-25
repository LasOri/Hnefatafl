import Testing
@testable import Hnefatafl

@Suite("Adjacent Threat Map Tests")
struct AdjacentThreatMapTests {

    @Test("empty board has no threats")
    func emptyBoardNoThreats() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let map = AdjacentThreatMapBuilder.build(position: position, by: .attacker)
        #expect(map.threatenedCount == 0)
    }

    @Test("single attacker threatens adjacent squares")
    func singleAttackerThreatsAdjacent() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let map = AdjacentThreatMapBuilder.build(position: position, by: .attacker)
        #expect(map.isThreatened(row: 5, col: 6))
        #expect(map.isThreatened(row: 5, col: 4))
        #expect(map.isThreatened(row: 4, col: 5))
        #expect(map.isThreatened(row: 6, col: 5))
        #expect(map.threatenedCount == 4)
    }

    @Test("corner piece threatens only 2 squares")
    func cornerPieceThreatens2() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let map = AdjacentThreatMapBuilder.build(position: position, by: .attacker)
        #expect(map.threatenedCount == 2)
        #expect(map.isThreatened(row: 0, col: 1))
        #expect(map.isThreatened(row: 1, col: 0))
    }

    @Test("defender threats include king adjacency")
    func defenderThreatsIncludeKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let map = AdjacentThreatMapBuilder.build(position: position, by: .defender)
        #expect(map.threatenedCount == 4)
    }

    @Test("out of bounds returns false")
    func outOfBoundsReturnsFalse() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let map = AdjacentThreatMapBuilder.build(position: position, by: .attacker)
        #expect(!map.isThreatened(row: -1, col: 0))
        #expect(!map.isThreatened(row: 11, col: 5))
    }

    @Test("attacker map ignores defenders")
    func attackerMapIgnoresDefenders() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let map = AdjacentThreatMapBuilder.build(position: position, by: .attacker)
        #expect(map.threatenedCount == 0)
    }
}
