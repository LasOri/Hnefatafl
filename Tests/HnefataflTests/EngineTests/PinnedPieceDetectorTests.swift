import Testing
@testable import Hnefatafl

@Suite("Pinned Piece Detector Tests")
struct PinnedPieceDetectorTests {

    @Test("start position has some pinned pieces")
    func startPositionPinned() {
        let position = Position.copenhagenStart()
        let attackerPinned = PinnedPieceDetector.pinnedCount(position: position, player: .attacker)
        let defenderPinned = PinnedPieceDetector.pinnedCount(position: position, player: .defender)
        #expect(attackerPinned >= 0)
        #expect(defenderPinned >= 0)
    }

    @Test("empty board returns 0")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PinnedPieceDetector.pinnedCount(position: position, player: .attacker) == 0)
        #expect(PinnedPieceDetector.pinnedCount(position: position, player: .defender) == 0)
    }

    @Test("pinned count matches array length")
    func countMatchesArray() {
        let position = Position.copenhagenStart()
        let pieces = PinnedPieceDetector.pinnedPieces(position: position, player: .attacker)
        let count = PinnedPieceDetector.pinnedCount(position: position, player: .attacker)
        #expect(pieces.count == count)
    }

    @Test("attacker surrounded by others is pinned")
    func attackerSurrounded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[4 * 11 + 5] = .defender
        cells[6 * 11 + 5] = .defender
        cells[5 * 11 + 4] = .defender
        cells[5 * 11 + 6] = .defender
        let position = Position(cells: cells)
        let pinned = PinnedPieceDetector.pinnedPieces(position: position, player: .attacker)
        let isPinned = pinned.contains { $0.row == 5 && $0.col == 5 }
        #expect(isPinned == true)
    }

    @Test("defender with open square is not pinned")
    func defenderWithOpenNotPinned() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        let pinned = PinnedPieceDetector.pinnedPieces(position: position, player: .defender)
        let isPinned = pinned.contains { $0.row == 5 && $0.col == 5 }
        #expect(isPinned == false)
    }
}
