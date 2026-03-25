enum PressureScore {
    static func pressure(position: Position, player: Player) -> Int {
        var count = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let belongs: Bool
                switch player {
                case .attacker: belongs = piece.isAttackerSide
                case .defender: belongs = piece.isDefenderSide
                }
                guard belongs else { continue }
                for (dr, dc) in directions {
                    let nr = row + dr
                    let nc = col + dc
                    guard nr >= 0 && nr < Position.boardSize && nc >= 0 && nc < Position.boardSize else { continue }
                    guard let neighbor = position.pieceAt(row: nr, col: nc) else { continue }
                    let isEnemy: Bool
                    switch player {
                    case .attacker: isEnemy = neighbor.isDefenderSide
                    case .defender: isEnemy = neighbor.isAttackerSide
                    }
                    if isEnemy { count += 1 }
                }
            }
        }
        return count
    }

    static func netPressure(position: Position) -> Int {
        pressure(position: position, player: .attacker) - pressure(position: position, player: .defender)
    }
}
