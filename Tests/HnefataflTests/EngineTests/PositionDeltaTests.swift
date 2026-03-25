import Testing
@testable import Hnefatafl

@Suite("PositionDelta Tests")
struct PositionDeltaTests {

    @Test("identical positions have no changes")
    func identicalPositions() {
        let position = Position.copenhagenStart()
        let delta = PositionDelta.diff(from: position, to: position)
        #expect(delta.totalChanges == 0)
    }

    @Test("adding a piece shows as added")
    func addedPiece() {
        let from = Position(cells: Array(repeating: nil, count: 121))
        let to = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .build()
        let delta = PositionDelta.diff(from: from, to: to)
        #expect(delta.addedPieces.count == 1)
        #expect(delta.removedPieces.count == 0)
    }

    @Test("removing a piece shows as removed")
    func removedPiece() {
        let from = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .build()
        let to = Position(cells: Array(repeating: nil, count: 121))
        let delta = PositionDelta.diff(from: from, to: to)
        #expect(delta.removedPieces.count == 1)
        #expect(delta.addedPieces.count == 0)
    }

    @Test("totalChanges counts both added and removed")
    func totalChanges() {
        let from = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .build()
        let to = emptyBoard()
            .placing(.defender, row: 1, col: 1)
            .build()
        let delta = PositionDelta.diff(from: from, to: to)
        #expect(delta.totalChanges == 2)
    }

    @Test("PositionChange equality")
    func positionChangeEquality() {
        let a = PositionChange(addedPieces: [], removedPieces: [])
        let b = PositionChange(addedPieces: [], removedPieces: [])
        #expect(a == b)
    }
}
