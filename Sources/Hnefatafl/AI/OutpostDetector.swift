enum OutpostDetector {
    static func outposts(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                if isOutpost(row: row, col: col, position: position, player: player) {
                    result.append((row, col))
                }
            }
        }
        return result
    }

    private static func isOutpost(row: Int, col: Int, position: Position, player: Player) -> Bool {
        var friendlyNeighbors = 0
        var enemyNeighbors = 0
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            let r = row + dr, c = col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            guard let p = position.pieceAt(row: r, col: c) else { continue }
            let isPl: Bool
            switch p {
            case .attacker: isPl = player == .attacker
            case .defender, .king: isPl = player == .defender
            }
            if isPl { friendlyNeighbors += 1 } else { enemyNeighbors += 1 }
        }
        return friendlyNeighbors >= 2 && enemyNeighbors == 0
    }
}
