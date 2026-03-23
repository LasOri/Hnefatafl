import Testing
@testable import Hnefatafl

@Suite("Capture Tests")
struct CaptureTests {

    @Test("piece sandwiched horizontally is captured")
    func applyMove_sandwichHorizontal_capturesPiece() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 3)
            .placing(.defender, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let move = Move(fromRow: 5, fromCol: 6, toRow: 5, toCol: 5)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 5, col: 4) == nil)
        #expect(result.pieceAt(row: 5, col: 3) == .attacker)
        #expect(result.pieceAt(row: 5, col: 5) == .attacker)
    }

    @Test("piece sandwiched vertically is captured")
    func applyMove_sandwichVertical_capturesPiece() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .build()
        let move = Move(fromRow: 6, fromCol: 5, toRow: 5, toCol: 5)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 4, col: 5) == nil)
    }

    @Test("multiple pieces captured in one move")
    func applyMove_multiCapture_removesMultiplePieces() {
        let position = emptyBoard()
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 7, col: 5)
            .placing(.attacker, row: 5, col: 3)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let move = Move(fromRow: 5, fromCol: 6, toRow: 5, toCol: 5)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 4, col: 5) == nil)
        #expect(result.pieceAt(row: 6, col: 5) == nil)
        #expect(result.pieceAt(row: 5, col: 4) == nil)
    }

    @Test("corner square acts as hostile for capture")
    func applyMove_cornerHostile_capturesPiece() {
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 1)
            .placing(.attacker, row: 0, col: 3)
            .build()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 0, col: 1) == nil)
    }

    @Test("empty throne acts as hostile for capture")
    func applyMove_throneHostile_capturesPiece() {
        let position = emptyBoard()
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 2, col: 5)
            .build()
        let move = Move(fromRow: 2, fromCol: 5, toRow: 3, toCol: 5)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 4, col: 5) == nil)
    }
}
