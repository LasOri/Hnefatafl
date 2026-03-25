enum OverextensionEval {
    static func overextendedPieces(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        let piece: Piece = player == .attacker ? .attacker : .defender
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == piece {
                    if !hasAdjacentAlly(position: position, row: row, col: col, piece: piece) {
                        let isDeep = isInEnemyTerritory(row: row, col: col, player: player)
                        if isDeep { result.append((row, col)) }
                    }
                }
            }
        }
        return result
    }

    static func overextensionPenalty(position: Position, player: Player) -> Int {
        overextendedPieces(position: position, player: player).count * 5
    }

    private static func hasAdjacentAlly(position: Position, row: Int, col: Int, piece: Piece) -> Bool {
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dr, dc) in dirs {
            let nr = row + dr
            let nc = col + dc
            guard nr >= 0, nr < Position.boardSize, nc >= 0, nc < Position.boardSize else { continue }
            let p = position.pieceAt(row: nr, col: nc)
            if p == piece || (piece == .defender && p == .king) || (piece == .king && p == .defender) {
                return true
            }
        }
        return false
    }

    private static func isInEnemyTerritory(row: Int, col: Int, player: Player) -> Bool {
        let center = Position.boardSize / 2
        let dist = abs(row - center) + abs(col - center)
        switch player {
        case .attacker: return dist <= 2
        case .defender: return dist > Position.boardSize / 3
        }
    }
}
