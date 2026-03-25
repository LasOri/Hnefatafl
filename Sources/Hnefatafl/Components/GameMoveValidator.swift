enum GameMoveValidationError: String, Equatable {
    case noPieceAtSource = "No piece at source"
    case wrongPlayer = "Not your piece"
    case illegalMove = "Illegal move"
    case gameOver = "Game is over"
}

enum GameMoveValidator {
    static func validate(move: Move, game: Game) -> GameMoveValidationError? {
        guard game.status == .inProgress else { return .gameOver }
        guard let piece = game.position.pieceAt(row: move.fromRow, col: move.fromCol) else {
            return .noPieceAtSource
        }
        let piecePlayer: Player
        switch piece {
        case .attacker: piecePlayer = .attacker
        case .defender, .king: piecePlayer = .defender
        }
        guard piecePlayer == game.currentPlayer else { return .wrongPlayer }
        let legal = game.position.legalMoves(forPieceAtRow: move.fromRow, col: move.fromCol)
        guard legal.contains(move) else { return .illegalMove }
        return nil
    }
}
