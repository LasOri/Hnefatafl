import Testing
@testable import Hnefatafl

@Suite("Defender Reach Tests")
struct DefenderReachTests {

    @Test("empty board has zero reachable squares")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(DefenderReach.reachableInOne(position: pos) == 0)
    }

    @Test("empty board has zero total reach")
    func emptyBoardTotalZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(DefenderReach.totalReach(position: pos) == 0)
    }

    @Test("start position has positive reachable squares")
    func startPositionPositive() {
        let pos = Position.copenhagenStart()
        #expect(DefenderReach.reachableInOne(position: pos) > 0)
    }

    @Test("total reach includes occupied squares")
    func totalReachIncludesOccupied() {
        let pos = Position.copenhagenStart()
        #expect(DefenderReach.totalReach(position: pos) >= DefenderReach.reachableInOne(position: pos))
    }

    @Test("lone king reachable squares are positive")
    func loneKingReachable() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(DefenderReach.reachableInOne(position: pos) > 0)
    }

    @Test("attackers only means zero reach")
    func attackersOnlyZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        let pos = Position(cells: cells)
        #expect(DefenderReach.reachableInOne(position: pos) == 0)
    }
}
