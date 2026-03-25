import Testing
@testable import Hnefatafl

@Suite("KingCorridorScan Tests")
struct KingCorridorScanTests {
    @Test("Start position has limited clear corridors")
    func startPositionCorridors() {
        let position = Position.copenhagenStart()
        let count = KingCorridorScan.clearCorridors(position: position)
        #expect(count >= 0)
        #expect(count <= 4)
    }

    @Test("Empty board with king has four clear corridors")
    func kingAloneHasFourCorridors() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let count = KingCorridorScan.clearCorridors(position: position)
        #expect(count == 4)
    }

    @Test("No king returns zero corridors")
    func noKingZeroCorridors() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let count = KingCorridorScan.clearCorridors(position: position)
        #expect(count == 0)
    }

    @Test("Best corridor length is nil when no king")
    func noKingNilLength() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let length = KingCorridorScan.bestCorridorLength(position: position)
        #expect(length == nil)
    }

    @Test("Best corridor length for king at center")
    func bestLengthKingAtCenter() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let length = KingCorridorScan.bestCorridorLength(position: position)
        #expect(length != nil)
        #expect(length! == 10)
    }

    @Test("King at corner has zero-length corridor")
    func kingAtCorner() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let length = KingCorridorScan.bestCorridorLength(position: position)
        #expect(length == 0)
    }

    @Test("Blocked corridor not counted")
    func blockedCorridorNotCounted() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 3] = .attacker
        cells[3 * 11 + 5] = .attacker
        cells[5 * 11 + 7] = .attacker
        cells[7 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let count = KingCorridorScan.clearCorridors(position: position)
        #expect(count < 4)
    }
}
