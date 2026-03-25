import Testing
@testable import Hnefatafl

@Suite("PositionDiff Tests")
struct PositionDiffTests {

    @Test("identical positions have no changes")
    func identical() {
        let pos = Position.copenhagenStart()
        let diff = PositionDiff.compare(before: pos, after: pos)
        #expect(diff.added.isEmpty)
        #expect(diff.removed.isEmpty)
    }

    @Test("empty to one piece shows addition")
    func singleAddition() {
        let before = Position(cells: Array(repeating: nil, count: 121))
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let after = Position(cells: cells)
        let diff = PositionDiff.compare(before: before, after: after)
        #expect(diff.added.count == 1)
        #expect(diff.added[0].piece == .attacker)
        #expect(diff.added[0].row == 0)
        #expect(diff.added[0].col == 0)
        #expect(diff.removed.isEmpty)
    }

    @Test("one piece to empty shows removal")
    func singleRemoval() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let before = Position(cells: cells)
        let after = Position(cells: Array(repeating: nil, count: 121))
        let diff = PositionDiff.compare(before: before, after: after)
        #expect(diff.removed.count == 1)
        #expect(diff.removed[0].piece == .attacker)
        #expect(diff.added.isEmpty)
    }

    @Test("piece move shows removal and addition")
    func pieceMove() {
        var beforeCells: [Piece?] = Array(repeating: nil, count: 121)
        beforeCells[0] = .attacker
        let before = Position(cells: beforeCells)

        var afterCells: [Piece?] = Array(repeating: nil, count: 121)
        afterCells[5] = .attacker
        let after = Position(cells: afterCells)

        let diff = PositionDiff.compare(before: before, after: after)
        #expect(diff.removed.count == 1)
        #expect(diff.added.count == 1)
        #expect(diff.removed[0].row == 0)
        #expect(diff.removed[0].col == 0)
        #expect(diff.added[0].row == 0)
        #expect(diff.added[0].col == 5)
    }

    @Test("capture shows removed piece")
    func capture() {
        var beforeCells: [Piece?] = Array(repeating: nil, count: 121)
        beforeCells[0] = .attacker
        beforeCells[1] = .defender
        let before = Position(cells: beforeCells)

        var afterCells: [Piece?] = Array(repeating: nil, count: 121)
        afterCells[1] = .attacker
        let after = Position(cells: afterCells)

        let diff = PositionDiff.compare(before: before, after: after)
        let removedPieces = diff.removed.map(\.piece)
        #expect(removedPieces.contains(.attacker))
        #expect(removedPieces.contains(.defender))
    }

    @Test("changedSquareCount reflects total changes")
    func changedCount() {
        let before = Position(cells: Array(repeating: nil, count: 121))
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        cells[1] = .attacker
        let after = Position(cells: cells)
        let diff = PositionDiff.compare(before: before, after: after)
        #expect(diff.changedSquareCount == 2)
    }

    @Test("PieceChange is Equatable")
    func equatable() {
        let a = PieceChange(piece: .attacker, row: 0, col: 0)
        let b = PieceChange(piece: .attacker, row: 0, col: 0)
        #expect(a == b)
    }

    @Test("hasChanges is false for identical")
    func noChanges() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let diff = PositionDiff.compare(before: pos, after: pos)
        #expect(!diff.hasChanges)
    }

    @Test("hasChanges is true when different")
    func hasChanges() {
        let before = Position(cells: Array(repeating: nil, count: 121))
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let after = Position(cells: cells)
        let diff = PositionDiff.compare(before: before, after: after)
        #expect(diff.hasChanges)
    }
}
