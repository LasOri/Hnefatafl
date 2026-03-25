import Testing
@testable import Hnefatafl

@Suite("Escape Path Blocker Tests")
struct EscapePathBlockerTests {

    @Test("king on edge row with attacker blocking corner")
    func kingOnEdgeRowBlocked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 2] = .attacker
        let pos = Position(cells: cells)
        let blockers = EscapePathBlocker.blockingPieces(position: pos)
        #expect(blockers > 0)
    }

    @Test("empty board with king has no blockers")
    func emptyBoardNoBlockers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let blockers = EscapePathBlocker.blockingPieces(position: pos)
        #expect(blockers == 0)
    }

    @Test("no king returns zero blockers")
    func noKingZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(EscapePathBlocker.blockingPieces(position: pos) == 0)
    }

    @Test("attacker on escape path blocks corner")
    func attackerBlocksCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 2] = .attacker
        let pos = Position(cells: cells)
        #expect(EscapePathBlocker.isCornerBlocked(position: pos, cornerRow: 0, cornerCol: 0))
    }

    @Test("isCornerBlocked returns false for clear path")
    func clearPathNotBlocked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(!EscapePathBlocker.isCornerBlocked(position: pos, cornerRow: 0, cornerCol: 0))
    }

    @Test("isCornerBlocked returns false without king")
    func noKingNotBlocked() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(!EscapePathBlocker.isCornerBlocked(position: pos, cornerRow: 0, cornerCol: 0))
    }

    @Test("multiple attackers on path count individually")
    func multipleBlockers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        cells[0 * 11 + 2] = .attacker
        cells[0 * 11 + 8] = .attacker
        let pos = Position(cells: cells)
        let blockers = EscapePathBlocker.blockingPieces(position: pos)
        #expect(blockers >= 2)
    }
}
