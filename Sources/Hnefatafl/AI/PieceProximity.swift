enum PieceProximity {
    static func nearestEnemy(row: Int, col: Int, position: Position, player: Player) -> Int {
        var minDist = Int.max
        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: r, col: c) else { continue }
                let isEnemy: Bool
                switch piece {
                case .attacker: isEnemy = player != .attacker
                case .defender, .king: isEnemy = player != .defender
                }
                guard isEnemy else { continue }
                let dist = abs(r - row) + abs(c - col)
                minDist = min(minDist, dist)
            }
        }
        return minDist == Int.max ? 0 : minDist
    }

    static func averageProximity(position: Position, player: Player) -> Double {
        var total = 0
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isP: Bool
                switch piece {
                case .attacker: isP = player == .attacker
                case .defender, .king: isP = player == .defender
                }
                guard isP else { continue }
                total += nearestEnemy(row: row, col: col, position: position, player: player)
                count += 1
            }
        }
        return count > 0 ? Double(total) / Double(count) : 0
    }
}
