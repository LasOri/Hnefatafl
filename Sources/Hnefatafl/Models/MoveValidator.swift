enum InvalidMoveReason: Equatable {
    case blocked
    case diagonal
    case noMovement
    case outOfBounds

    var message: String {
        switch self {
        case .blocked: return "Path is blocked"
        case .diagonal: return "Pieces move in straight lines only"
        case .noMovement: return "Select a different square"
        case .outOfBounds: return "Move is outside the board"
        }
    }
}

struct MoveValidator {
    static func validate(move: Move, in game: Game) -> InvalidMoveReason? {
        let size = Position.boardSize

        guard move.toRow >= 0, move.toRow < size,
              move.toCol >= 0, move.toCol < size else {
            return .outOfBounds
        }

        guard move.fromRow != move.toRow || move.fromCol != move.toCol else {
            return .noMovement
        }

        guard move.fromRow == move.toRow || move.fromCol == move.toCol else {
            return .diagonal
        }

        let legalMoves = game.position.legalMoves(forPieceAtRow: move.fromRow, col: move.fromCol)
        if legalMoves.contains(move) {
            return nil
        }

        return .blocked
    }
}
