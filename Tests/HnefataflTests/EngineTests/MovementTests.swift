import Testing
@testable import Hnefatafl

@Suite("Movement Tests")
struct MovementTests {

    @Test("piece moves one square horizontally")
    func applyMove_oneSquareRight_movesPiece() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 6)

        let result = position.applyMove(move)

        #expect(result.pieceAt(row: 5, col: 5) == nil)
        #expect(result.pieceAt(row: 5, col: 6) == .attacker)
    }

    @Test("lone piece on empty board has 20 legal moves")
    func legalMoves_lonePieceCenter_has20Moves() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()

        let moves = position.legalMoves(forPieceAtRow: 5, col: 5)

        #expect(moves.count == 20)
    }

    @Test("piece cannot move through another piece")
    func legalMoves_blockedByPiece_stopsBeforeIt() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 7)
            .build()

        let moves = position.legalMoves(forPieceAtRow: 5, col: 5)
        let rightMoves = moves.filter { $0.toRow == 5 && $0.toCol > 5 }

        #expect(rightMoves.count == 1)
        #expect(rightMoves[0].toCol == 6)
    }

    @Test("attacker cannot land on corner square")
    func legalMoves_attackerNearCorner_cannotLandOnCorner() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 1)
            .build()

        let moves = position.legalMoves(forPieceAtRow: 0, col: 1)
        let cornerMove = moves.first { $0.toRow == 0 && $0.toCol == 0 }

        #expect(cornerMove == nil)
    }

    @Test("king can land on corner square")
    func legalMoves_kingNearCorner_canLandOnCorner() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .build()

        let moves = position.legalMoves(forPieceAtRow: 0, col: 1)
        let cornerMove = moves.first { $0.toRow == 0 && $0.toCol == 0 }

        #expect(cornerMove != nil)
    }

    @Test("no piece can land on empty throne")
    func legalMoves_emptyThrone_cannotBeEntered() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 3)
            .build()

        let moves = position.legalMoves(forPieceAtRow: 5, col: 3)
        let throneMove = moves.first { $0.toRow == 5 && $0.toCol == 5 }

        #expect(throneMove == nil)
    }
}
