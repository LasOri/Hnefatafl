import Testing
@testable import Hnefatafl

@Suite("ControlZone Tests")
struct ControlZoneTests {

    @Test("starting position has zones for both players")
    func bothPlayers() {
        let pos = Position.copenhagenStart()
        let attackerZone = ControlZone.compute(position: pos, for: .attacker)
        let defenderZone = ControlZone.compute(position: pos, for: .defender)
        #expect(!attackerZone.squares.isEmpty)
        #expect(!defenderZone.squares.isEmpty)
    }

    @Test("empty board has no zones")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let zone = ControlZone.compute(position: pos, for: .attacker)
        #expect(zone.squares.isEmpty)
    }

    @Test("zone count is non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let zone = ControlZone.compute(position: pos, for: .attacker)
        #expect(zone.squareCount >= 0)
    }

    @Test("single piece controls adjacent squares")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let zone = ControlZone.compute(position: pos, for: .attacker)
        #expect(zone.squareCount > 0)
    }

    @Test("ControlZoneResult is Equatable")
    func equatable() {
        let a = ControlZoneResult(squares: [], squareCount: 0)
        let b = ControlZoneResult(squares: [], squareCount: 0)
        #expect(a == b)
    }

    @Test("zones don't exceed board size")
    func bounded() {
        let pos = Position.copenhagenStart()
        let zone = ControlZone.compute(position: pos, for: .attacker)
        #expect(zone.squareCount <= 121)
    }
}
