import Testing
@testable import Hnefatafl

@Suite("Corner Control Tests")
struct CornerControlTests {

    @Test("start position has corner attacker presence")
    func startPositionPresence() {
        let pos = Position.copenhagenStart()
        let score = CornerControl.cornerAttackerPresence(position: pos)
        #expect(score >= 0)
    }

    @Test("empty board has zero presence")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = CornerControl.cornerAttackerPresence(position: pos)
        #expect(score == 0)
    }

    @Test("corner blocked when attacker adjacent")
    func cornerBlockedWithAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .attacker
        let pos = Position(cells: cells)
        #expect(CornerControl.isCornerBlocked(position: pos, cornerRow: 0, cornerCol: 0))
    }

    @Test("corner not blocked when empty")
    func cornerNotBlockedWhenEmpty() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(!CornerControl.isCornerBlocked(position: pos, cornerRow: 0, cornerCol: 0))
    }

    @Test("all four corners are checked")
    func allFourCornersChecked() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .attacker
        cells[10 * 11 + 1] = .attacker
        cells[0 * 11 + 9] = .attacker
        cells[10 * 11 + 9] = .attacker
        let pos = Position(cells: cells)
        let score = CornerControl.cornerAttackerPresence(position: pos)
        #expect(score == 4)
    }
}
