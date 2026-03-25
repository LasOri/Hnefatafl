enum StrongPointEval {
    static func strongPoints(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard position.pieceAt(row: row, col: col) == nil else { continue }
                if isStrongPoint(position: position, row: row, col: col, player: player) {
                    result.append((row, col))
                }
            }
        }
        return result
    }

    static func strongPointScore(position: Position, player: Player) -> Int {
        strongPoints(position: position, player: player).count
    }

    private static func isStrongPoint(position: Position, row: Int, col: Int, player: Player) -> Bool {
        let directions: [(Int, Int)] = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var friendlyNeighbors = 0
        var enemyNeighbors = 0

        for (dr, dc) in directions {
            let nr = row + dr
            let nc = col + dc
            guard nr >= 0 && nr < Position.boardSize && nc >= 0 && nc < Position.boardSize else {
                continue
            }
            guard let piece = position.pieceAt(row: nr, col: nc) else { continue }
            let isFriendly: Bool
            switch player {
            case .attacker:
                isFriendly = piece == .attacker
            case .defender:
                isFriendly = piece == .defender || piece == .king
            }
            if isFriendly {
                friendlyNeighbors += 1
            } else {
                enemyNeighbors += 1
            }
        }

        return friendlyNeighbors >= 2 && enemyNeighbors == 0
    }
}
