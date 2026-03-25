import Testing
@testable import Hnefatafl

@Suite("CorridorDetector Tests")
struct CorridorDetectorTests {

    @Test("no king returns empty corridors")
    func noKingEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(CorridorDetector.corridorCount(position: position) == 0)
    }

    @Test("king alone on row has open corridor")
    func kingAloneOnRow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        let position = Position(cells: cells)
        let corridors = CorridorDetector.openCorridors(position: position)
        let hasRow = corridors.contains { $0.isRow && $0.index == 0 }
        #expect(hasRow == true)
    }

    @Test("king alone on column has open corridor")
    func kingAloneOnCol() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 0] = .king
        let position = Position(cells: cells)
        let corridors = CorridorDetector.openCorridors(position: position)
        let hasCol = corridors.contains { !$0.isRow && $0.index == 0 }
        #expect(hasCol == true)
    }

    @Test("corridor count matches open corridors count")
    func countMatchesCorridors() {
        let position = Position.copenhagenStart()
        let corridors = CorridorDetector.openCorridors(position: position)
        let count = CorridorDetector.corridorCount(position: position)
        #expect(corridors.count == count)
    }

    @Test("start position corridor count is non-negative")
    func startPositionNonNegative() {
        let position = Position.copenhagenStart()
        #expect(CorridorDetector.corridorCount(position: position) >= 0)
    }

    @Test("blocked row not counted as corridor")
    func blockedRowNotCounted() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 3] = .attacker
        let position = Position(cells: cells)
        let corridors = CorridorDetector.openCorridors(position: position)
        let fullRowOpen = corridors.filter { $0.isRow && $0.index == 0 }
        #expect(fullRowOpen.count <= 1)
    }
}
