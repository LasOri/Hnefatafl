enum ProbeSearch {
    static func probe(position: Position, player: Player) -> Int {
        let defScore = defenderEval(position: position)
        return player == .defender ? defScore : -defScore
    }

    static func probeWithCaptures(position: Position, player: Player) -> Int {
        let baseScore = probe(position: position, player: player)
        let moves = position.allLegalMoves(for: player)
        var bestCapture = 0
        let opponent: Player = player == .attacker ? .defender : .attacker
        for move in moves {
            let newPos = position.applyMove(move)
            let before: Int, after: Int
            switch opponent {
            case .attacker: before = position.attackerCount; after = newPos.attackerCount
            case .defender: before = position.defenderCount; after = newPos.defenderCount
            }
            let captured = before - after
            if captured > bestCapture { bestCapture = captured }
        }
        return baseScore + bestCapture * 10
    }

    private static func defenderEval(position: Position) -> Int {
        var score = 0
        score += position.defenderCount * 10
        score -= position.attackerCount * 10
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    let cornerDist = min(
                        row + col,
                        row + (Position.boardSize - 1 - col),
                        (Position.boardSize - 1 - row) + col,
                        (Position.boardSize - 1 - row) + (Position.boardSize - 1 - col)
                    )
                    score -= cornerDist * 5
                }
            }
        }
        return score
    }
}
