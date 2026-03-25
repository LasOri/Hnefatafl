enum QuiescenceSearch {
    static func search(position: Position, player: Player, alpha: Int, beta: Int) -> Int {
        let standPat = staticEval(position: position, player: player)
        if standPat >= beta { return beta }
        var currentAlpha = max(alpha, standPat)

        let captureMoves = findCaptureMoves(position: position, player: player)
        for move in captureMoves {
            let newPos = position.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            let score = -search(position: newPos, player: opponent, alpha: -beta, beta: -currentAlpha)
            if score >= beta { return beta }
            currentAlpha = max(currentAlpha, score)
        }
        return currentAlpha
    }

    static func findCaptureMoves(position: Position, player: Player) -> [Move] {
        let allMoves = position.allLegalMoves(for: player)
        return allMoves.filter { move in
            let before = position
            let after = position.applyMove(move)
            let opponent: Player = player == .attacker ? .defender : .attacker
            let beforeCount: Int
            let afterCount: Int
            switch opponent {
            case .attacker:
                beforeCount = before.attackerCount
                afterCount = after.attackerCount
            case .defender:
                beforeCount = before.defenderCount
                afterCount = after.defenderCount
            }
            return afterCount < beforeCount
        }
    }

    private static func staticEval(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return position.attackerCount - position.defenderCount
        case .defender: return position.defenderCount - position.attackerCount
        }
    }
}
