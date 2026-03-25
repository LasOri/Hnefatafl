enum PassivityDetector {
    static func passivityScore(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        guard !moves.isEmpty else { return 100 }

        var shortMoveCount = 0
        var totalDistance = 0
        for move in moves {
            let dist = abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
            totalDistance += dist
            if dist <= 1 { shortMoveCount += 1 }
        }

        let avgDist = totalDistance / moves.count
        let shortRatio = (shortMoveCount * 100) / moves.count
        var score = 0

        if avgDist <= 2 { score += 3 }
        if shortRatio > 50 { score += 2 }

        let pieceCount = player == .attacker ? position.attackerCount : position.defenderCount
        let movePerPiece = pieceCount > 0 ? moves.count / pieceCount : 0
        if movePerPiece <= 2 { score += 2 }

        return score
    }

    static func isPassive(position: Position, player: Player) -> Bool {
        passivityScore(position: position, player: player) >= 5
    }
}
