enum MoveValidationStatus: Equatable {
    case valid
    case invalid(String)
}

struct MoveValidationResult: Equatable {
    let status: MoveValidationStatus
    let move: Move?

    static func validate(move: Move, position: Position) -> MoveValidationResult {
        guard move.fromRow >= 0 && move.fromRow < Position.boardSize &&
              move.fromCol >= 0 && move.fromCol < Position.boardSize &&
              move.toRow >= 0 && move.toRow < Position.boardSize &&
              move.toCol >= 0 && move.toCol < Position.boardSize else {
            return MoveValidationResult(status: .invalid("Out of bounds"), move: nil)
        }

        guard position.pieceAt(row: move.fromRow, col: move.fromCol) != nil else {
            return MoveValidationResult(status: .invalid("No piece at source"), move: nil)
        }

        guard position.pieceAt(row: move.toRow, col: move.toCol) == nil else {
            return MoveValidationResult(status: .invalid("Destination occupied"), move: nil)
        }

        let legal = position.legalMoves(forPieceAtRow: move.fromRow, col: move.fromCol)
        if legal.contains(move) {
            return MoveValidationResult(status: .valid, move: move)
        }

        return MoveValidationResult(status: .invalid("Not a legal move"), move: nil)
    }
}
