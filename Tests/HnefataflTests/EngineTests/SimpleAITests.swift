import Testing
@testable import Hnefatafl

@Suite("SimpleAI Tests")
struct SimpleAITests {

    @Test("picks a legal move for current player")
    func picksLegalMove() {
        let game = Game()
        let move = SimpleAI.pickMove(game: game)

        #expect(move != nil)
        let allMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(allMoves.contains(move!))
    }

    @Test("returns nil when no moves available")
    func returnsNilNoMoves() {
        let position = emptyBoard().placing(.king, row: 5, col: 5).build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])

        let move = SimpleAI.pickMove(game: game)
        #expect(move == nil)
    }

    @Test("picks from different pieces across calls")
    func picksDifferentPieces() {
        let game = Game()
        var fromPositions: Set<String> = []

        for _ in 0..<20 {
            if let move = SimpleAI.pickMove(game: game) {
                fromPositions.insert("\(move.fromRow),\(move.fromCol)")
            }
        }

        #expect(fromPositions.count > 1)
    }

    @Test("move is valid for the game position")
    func moveIsValid() {
        let game = Game()
        guard let move = SimpleAI.pickMove(game: game) else {
            Issue.record("Expected a move")
            return
        }

        let piece = game.position.pieceAt(row: move.fromRow, col: move.fromCol)
        #expect(piece != nil)

        let pieceMoves = game.position.legalMoves(forPieceAtRow: move.fromRow, col: move.fromCol)
        #expect(pieceMoves.contains(move))
    }

    @Test("handles defender turn")
    func handlesDefenderTurn() {
        let game = Game()
        let moved = game.makeMove(
            game.position.allLegalMoves(for: .attacker).first!
        )

        let defenderMove = SimpleAI.pickMove(game: moved)
        #expect(defenderMove != nil)
    }
}
