enum RowColumnBalance {
    static func rowDistribution(position: Position, player: Player) -> [Int] {
        var dist = Array(repeating: 0, count: Position.boardSize)
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                if isPlayer { dist[row] += 1 }
            }
        }
        return dist
    }

    static func colDistribution(position: Position, player: Player) -> [Int] {
        var dist = Array(repeating: 0, count: Position.boardSize)
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                if isPlayer { dist[col] += 1 }
            }
        }
        return dist
    }
}
