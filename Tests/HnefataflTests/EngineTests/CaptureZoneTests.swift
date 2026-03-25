import Testing
@testable import Hnefatafl

@Suite("Capture Zone Tests")
struct CaptureZoneTests {

    @Test("no hotspots on empty board")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        #expect(CaptureZone.hotspotCount(position: position) == 0)
    }

    @Test("piece adjacent to enemy with empty square is a hotspot")
    func singleHotspot() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let count = CaptureZone.hotspotCount(position: position)
        #expect(count >= 1)
    }

    @Test("pieces with no adjacent enemy are not hotspots")
    func noEnemyNeighbor() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        cells[3 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(CaptureZone.hotspotCount(position: position) == 0)
    }

    @Test("hotspot count matches array length")
    func countMatchesArray() {
        let position = Position.copenhagenStart()
        let spots = CaptureZone.hotspots(position: position)
        #expect(spots.count == CaptureZone.hotspotCount(position: position))
    }

    @Test("hotspot coordinates are valid")
    func validCoordinates() {
        let position = Position.copenhagenStart()
        let spots = CaptureZone.hotspots(position: position)
        for spot in spots {
            #expect(spot.row >= 0 && spot.row < 11)
            #expect(spot.col >= 0 && spot.col < 11)
        }
    }

    @Test("completely surrounded piece is not a hotspot")
    func surroundedNotHotspot() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let spots = CaptureZone.hotspots(position: position)
        let defenderSpots = spots.filter { $0.row == 5 && $0.col == 5 }
        #expect(defenderSpots.isEmpty)
    }
}
