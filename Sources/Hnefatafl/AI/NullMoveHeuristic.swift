enum NullMoveHeuristic {
    static func nullMoveScore(position: Position, player: Player) -> Int {
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMoves = position.allLegalMoves(for: opponent)

        var worstSwing = 0
        for move in opponentMoves {
            let newPosition = position.applyMove(move)
            let pieceDiff = pieceDifference(position: newPosition, player: player)
            let originalDiff = pieceDifference(position: position, player: player)
            let swing = originalDiff - pieceDiff
            if swing > worstSwing {
                worstSwing = swing
            }
        }

        return -worstSwing
    }

    static func isNullMoveSafe(position: Position, player: Player) -> Bool {
        let score = nullMoveScore(position: position, player: player)
        return score >= -1
    }

    private static func pieceDifference(position: Position, player: Player) -> Int {
        if player == .attacker {
            return position.attackerCount - position.defenderCount
        } else {
            return position.defenderCount - position.attackerCount
        }
    }
}
