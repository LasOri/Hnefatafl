enum DiagonalControl {
    static func diagonalThreats(position: Position, player: Player) -> Int {
        var threats = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                for (dr, dc) in [(-1,-1),(-1,1),(1,-1),(1,1)] {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    if position.pieceAt(row: r, col: c) != nil { threats += 1 }
                }
            }
        }
        return threats
    }
}
