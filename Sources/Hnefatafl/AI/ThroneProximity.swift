enum ThroneProximity {
    static func distanceToThrone(row: Int, col: Int) -> Int {
        let center = Position.boardSize / 2
        return abs(row - center) + abs(col - center)
    }

    static func throneControlScore(position: Position) -> Int {
        let center = Position.boardSize / 2
        var attackerScore = 0
        var defenderScore = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let dist = abs(row - center) + abs(col - center)
                guard dist > 0 else { continue }
                let proximity = Position.boardSize - dist
                switch piece {
                case .attacker:
                    attackerScore += proximity
                case .defender, .king:
                    defenderScore += proximity
                }
            }
        }

        return defenderScore - attackerScore
    }
}
