import Testing
@testable import Hnefatafl

@Suite("PieceTracker Tests")
struct PieceTrackerTests {

    @Test("start position total pieces")
    func startPositionTotal() {
        let position = Position.copenhagenStart()
        #expect(PieceTracker.totalPieces(position: position) == 37)
    }

    @Test("empty board has zero pieces")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceTracker.totalPieces(position: position) == 0)
    }

    @Test("no difference when same position")
    func noDifference() {
        let position = Position.copenhagenStart()
        let diff = PieceTracker.pieceDifference(before: position, after: position)
        #expect(diff.attackersLost == 0)
        #expect(diff.defendersLost == 0)
    }

    @Test("detects attacker lost after capture")
    func detectAttackerLost() {
        let start = Position.copenhagenStart()
        var cells = start.cells
        cells[Position.index(row: 0, col: 3)] = nil
        let after = Position(cells: cells)
        let diff = PieceTracker.pieceDifference(before: start, after: after)
        #expect(diff.attackersLost == 1)
        #expect(diff.defendersLost == 0)
    }

    @Test("detects defender lost after capture")
    func detectDefenderLost() {
        let start = Position.copenhagenStart()
        var cells = start.cells
        cells[Position.index(row: 3, col: 5)] = nil
        let after = Position(cells: cells)
        let diff = PieceTracker.pieceDifference(before: start, after: after)
        #expect(diff.attackersLost == 0)
        #expect(diff.defendersLost == 1)
    }

    @Test("total pieces counts all piece types")
    func totalCountsAllTypes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .defender
        cells[2] = .king
        let position = Position(cells: cells)
        #expect(PieceTracker.totalPieces(position: position) == 3)
    }

    @Test("lost pieces clamp to zero")
    func lostPiecesClampToZero() {
        var before: [Piece?] = Array(repeating: nil, count: 121)
        before[0] = .attacker
        var after: [Piece?] = Array(repeating: nil, count: 121)
        after[0] = .attacker
        after[1] = .attacker
        let diff = PieceTracker.pieceDifference(before: Position(cells: before), after: Position(cells: after))
        #expect(diff.attackersLost == 0)
    }
}
