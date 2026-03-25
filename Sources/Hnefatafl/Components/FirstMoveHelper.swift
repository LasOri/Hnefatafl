struct FirstMoveSuggestion: Equatable {
    let move: Move
    let reason: String
}

enum FirstMoveHelper {
    static func suggest(position: Position, player: Player) -> FirstMoveSuggestion? {
        let moves = position.allLegalMoves(for: player)
        guard let first = moves.first else { return nil }
        let reason = player == .attacker ? "Advance toward the center" : "Protect the king"
        return FirstMoveSuggestion(move: first, reason: reason)
    }
}
