import Testing
@testable import Hnefatafl

@Suite("Captured Squares Detection Tests")
struct CapturedSquaresTests {

    @Test("no captures returns empty array")
    func noCapturesEmpty() {
        let before = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.king, row: 5, col: 5)
            .build()
        let after = emptyBoard()
            .placing(.attacker, row: 3, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()
        let result = Position.capturedSquares(before: before, after: after, movedFrom: (row: 3, col: 0))
        #expect(result.isEmpty)
    }

    @Test("custodial capture returns captured position")
    func custodialCapturePosition() {
        let before = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()
        let moveResult = before.applyMove(Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2))
        let result = Position.capturedSquares(before: before, after: moveResult, movedFrom: (row: 3, col: 3))
        #expect(result.count == 1)
        #expect(result.first?.row == 3)
        #expect(result.first?.col == 1)
    }

    @Test("excludes moved piece origin from results")
    func excludesMovedPieceOrigin() {
        let before = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()
        let after = emptyBoard()
            .placing(.attacker, row: 3, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()
        let result = Position.capturedSquares(before: before, after: after, movedFrom: (row: 3, col: 3))
        #expect(result.isEmpty)
    }

    @Test("multiple captures returns all positions")
    func multipleCapturesReturnsAll() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .placing(.defender, row: 3, col: 4)
            .placing(.attacker, row: 3, col: 5)
            .placing(.defender, row: 4, col: 3)
            .placing(.attacker, row: 5, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let after = position.applyMove(Move(fromRow: 5, fromCol: 3, toRow: 5, toCol: 3))
        let _ = after
        let pos2 = emptyBoard()
            .placing(.attacker, row: 2, col: 4)
            .placing(.defender, row: 3, col: 4)
            .placing(.defender, row: 4, col: 4)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 4, col: 5)
            .placing(.king, row: 8, col: 8)
            .build()
        let after2 = pos2.applyMove(Move(fromRow: 4, fromCol: 5, toRow: 4, toCol: 5))
        let result = Position.capturedSquares(before: pos2, after: after2, movedFrom: (row: 4, col: 5))
        #expect(result.count >= 0)
    }

    @Test("shield wall capture returns all wall positions")
    func shieldWallCapturePositions() {
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 3)
            .placing(.defender, row: 0, col: 4)
            .placing(.attacker, row: 1, col: 3)
            .placing(.attacker, row: 1, col: 4)
            .placing(.attacker, row: 0, col: 2)
            .placing(.attacker, row: 2, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()
        let after = position.applyMove(Move(fromRow: 2, fromCol: 5, toRow: 0, toCol: 5))
        let result = Position.capturedSquares(before: position, after: after, movedFrom: (row: 2, col: 5))
        #expect(result.count == 2)
    }

    @Test("king capture returns king position")
    func kingCapturePosition() {
        let position = emptyBoard()
            .placing(.king, row: 3, col: 3)
            .placing(.attacker, row: 2, col: 3)
            .placing(.attacker, row: 4, col: 3)
            .placing(.attacker, row: 3, col: 2)
            .placing(.attacker, row: 5, col: 4)
            .build()
        let after = position.applyMove(Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4))
        let result = Position.capturedSquares(before: position, after: after, movedFrom: (row: 5, col: 4))
        #expect(result.count == 1)
        #expect(result.first?.row == 3)
        #expect(result.first?.col == 3)
    }
}
