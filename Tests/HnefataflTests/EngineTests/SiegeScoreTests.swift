import Testing
@testable import Hnefatafl

@Suite("Siege Score Tests")
struct SiegeScoreTests {

    @Test("no king returns zero siege level")
    func noKingZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(SiegeScore.siegeLevel(position: pos) == 0)
    }

    @Test("isolated king has low siege level")
    func isolatedKingLow() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(SiegeScore.siegeLevel(position: pos) == 0)
    }

    @Test("surrounded king has high siege level")
    func surroundedKingHigh() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        #expect(SiegeScore.siegeLevel(position: pos) == 4)
    }

    @Test("isBesieged false for isolated king")
    func notBesiegedIsolated() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(!SiegeScore.isBesieged(position: pos))
    }

    @Test("isBesieged true when king has few escape directions")
    func besiegedFewEscapes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .attacker
        let pos = Position(cells: cells)
        #expect(SiegeScore.isBesieged(position: pos))
    }

    @Test("siege level increases with more blockades")
    func siegeIncreasesWithBlockades() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[5 * 11 + 5] = .king
        cells1[4 * 11 + 5] = .attacker
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .king
        cells2[4 * 11 + 5] = .attacker
        cells2[6 * 11 + 5] = .attacker
        cells2[5 * 11 + 4] = .attacker
        let pos2 = Position(cells: cells2)

        #expect(SiegeScore.siegeLevel(position: pos2) > SiegeScore.siegeLevel(position: pos1))
    }
}
