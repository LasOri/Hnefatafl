import Testing
@testable import Hnefatafl

@Suite("Defender Mobility Tests")
struct DefenderMobilityTests {

    @Test("empty board has zero total mobility")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(DefenderMobility.totalMobility(position: pos) == 0)
    }

    @Test("empty board has zero king mobility")
    func emptyBoardKingZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(DefenderMobility.kingMobility(position: pos) == 0)
    }

    @Test("start position has positive total mobility")
    func startPositionPositive() {
        let pos = Position.copenhagenStart()
        #expect(DefenderMobility.totalMobility(position: pos) > 0)
    }

    @Test("start position king is boxed in with zero mobility")
    func startPositionKingBoxedIn() {
        let pos = Position.copenhagenStart()
        #expect(DefenderMobility.kingMobility(position: pos) == 0)
    }

    @Test("king mobility is at most total mobility")
    func kingAtMostTotal() {
        let pos = Position.copenhagenStart()
        #expect(DefenderMobility.kingMobility(position: pos) <= DefenderMobility.totalMobility(position: pos))
    }

    @Test("attackers not counted in defender mobility")
    func attackersIgnored() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(DefenderMobility.totalMobility(position: pos) == 0)
    }

    @Test("lone king has equal king and total mobility")
    func loneKingEquals() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .king
        let pos = Position(cells: cells)
        #expect(DefenderMobility.kingMobility(position: pos) == DefenderMobility.totalMobility(position: pos))
    }
}
