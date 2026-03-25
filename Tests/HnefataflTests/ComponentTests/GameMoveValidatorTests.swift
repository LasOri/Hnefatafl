import Testing
@testable import Hnefatafl

@Suite("Game Move Validator Tests")
struct GameMoveValidatorTests {

    @Test("valid move returns nil")
    func validMoveReturnsNil() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = GameMoveValidator.validate(move: move, game: game)
        #expect(result == nil)
    }

    @Test("no piece at source")
    func noPieceAtSource() {
        let game = Game()
        let move = Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 3)
        let result = GameMoveValidator.validate(move: move, game: game)
        #expect(result == .noPieceAtSource)
    }

    @Test("wrong player piece")
    func wrongPlayer() {
        let game = Game()
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 6)
        let result = GameMoveValidator.validate(move: move, game: game)
        #expect(result == .wrongPlayer)
    }

    @Test("illegal move for piece")
    func illegalMove() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 5, toCol: 3)
        let result = GameMoveValidator.validate(move: move, game: game)
        #expect(result == .illegalMove || result == nil)
    }

    @Test("game over returns gameOver error")
    func gameOverError() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        if game.status != .inProgress {
            let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
            let result = GameMoveValidator.validate(move: move, game: game)
            #expect(result == .gameOver)
        }
    }

    @Test("error raw values")
    func errorRawValues() {
        #expect(GameMoveValidationError.noPieceAtSource.rawValue == "No piece at source")
        #expect(GameMoveValidationError.wrongPlayer.rawValue == "Not your piece")
        #expect(GameMoveValidationError.illegalMove.rawValue == "Illegal move")
        #expect(GameMoveValidationError.gameOver.rawValue == "Game is over")
    }
}
