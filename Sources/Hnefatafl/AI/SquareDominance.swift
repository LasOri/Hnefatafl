enum SquareDominance {
    static func dominantPlayer(row: Int, col: Int, position: Position) -> Player? {
        guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else {
            return nil
        }

        var attackerInfluence = 0
        var defenderInfluence = 0

        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: r, col: c) else { continue }
                let dist = abs(r - row) + abs(c - col)
                guard dist > 0 && dist <= 3 else { continue }
                let influence = 4 - dist
                switch piece {
                case .attacker: attackerInfluence += influence
                case .defender, .king: defenderInfluence += influence
                }
            }
        }

        if attackerInfluence > defenderInfluence { return .attacker }
        if defenderInfluence > attackerInfluence { return .defender }
        return nil
    }

    static func dominanceScore(position: Position) -> Int {
        var score = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let player = dominantPlayer(row: row, col: col, position: position) {
                    score += player == .attacker ? 1 : -1
                }
            }
        }
        return score
    }
}
