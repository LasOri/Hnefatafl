struct SequenceValidationResult: Equatable {
    let isValid: Bool
    let failingIndex: Int?
    let validMoveCount: Int
}

enum MoveSequenceValidator {
    static func validate(moves: [Move], from position: Position, startingPlayer: Player) -> SequenceValidationResult {
        guard !moves.isEmpty else {
            return SequenceValidationResult(isValid: true, failingIndex: nil, validMoveCount: 0)
        }

        var currentPos = position
        var currentPlayer = startingPlayer

        for (index, move) in moves.enumerated() {
            let legalMoves = currentPos.allLegalMoves(for: currentPlayer)
            guard legalMoves.contains(move) else {
                return SequenceValidationResult(isValid: false, failingIndex: index, validMoveCount: index)
            }
            currentPos = currentPos.applyMove(move)
            currentPlayer = currentPlayer == .attacker ? .defender : .attacker
        }

        return SequenceValidationResult(isValid: true, failingIndex: nil, validMoveCount: moves.count)
    }
}
