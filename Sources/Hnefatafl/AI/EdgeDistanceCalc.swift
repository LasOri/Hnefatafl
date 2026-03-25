enum EdgeDistanceCalc {
    static func minEdgeDistance(row: Int, col: Int) -> Int {
        min(row, col, Position.boardSize - 1 - row, Position.boardSize - 1 - col)
    }

    static func averageEdgeDistance(position: Position, player: Player) -> Double {
        var total = 0, count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                total += minEdgeDistance(row: row, col: col)
                count += 1
            }
        }
        return count > 0 ? Double(total) / Double(count) : 0
    }
}
