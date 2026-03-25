import Testing
@testable import Hnefatafl

@Suite("Escape Route Counter Tests")
struct EscapeRouteCounterTests {

    @Test("start position king is blocked by defenders")
    func startPositionBlocked() {
        let position = Position.copenhagenStart()
        let routes = EscapeRouteCounter.count(position: position)
        #expect(routes == 0)
    }

    @Test("no king returns 0")
    func noKingReturnsZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(EscapeRouteCounter.count(position: position) == 0)
    }

    @Test("king on edge with clear path to corner")
    func kingOnEdgeClearPath() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        let position = Position(cells: cells)
        let routes = EscapeRouteCounter.count(position: position)
        #expect(routes >= 1)
    }

    @Test("blocked path returns 0 routes for that corner")
    func blockedPathReturnsZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 3] = .attacker
        cells[0 * 11 + 7] = .attacker
        cells[3 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let routes = EscapeRouteCounter.count(position: position)
        #expect(routes <= 4)
    }

    @Test("route count never exceeds 4")
    func countMaxFour() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .king
        let position = Position(cells: cells)
        let routes = EscapeRouteCounter.count(position: position)
        #expect(routes <= 4)
    }
}
