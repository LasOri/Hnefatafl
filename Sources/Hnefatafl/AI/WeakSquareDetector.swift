enum WeakSquareDetector {
    static func weakSquares(position: Position, player: Player) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard position.pieceAt(row: row, col: col) == nil else { continue }
                var enemyCount = 0
                for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                    let r = row + dr
                    let c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if let p = position.pieceAt(row: r, col: c) {
                        let isEnemy: Bool
                        switch p {
                        case .attacker: isEnemy = player != .attacker
                        case .defender, .king: isEnemy = player != .defender
                        }
                        if isEnemy { enemyCount += 1 }
                    }
                }
                if enemyCount >= 2 { result.append((row, col)) }
            }
        }
        return result
    }
}
