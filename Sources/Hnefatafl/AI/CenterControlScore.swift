enum CenterControlScore {
    static func score(position: Position, player: Player) -> Int {
        var total = 0
        let center = Position.boardSize / 2
        let radius = 2

        for row in (center - radius)...(center + radius) {
            for col in (center - radius)...(center + radius) {
                guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else { continue }
                if let piece = position.pieceAt(row: row, col: col) {
                    let isPlayer: Bool
                    switch piece {
                    case .attacker: isPlayer = player == .attacker
                    case .defender, .king: isPlayer = player == .defender
                    }
                    if isPlayer {
                        let dist = abs(row - center) + abs(col - center)
                        total += max(0, radius + 1 - dist)
                    }
                }
            }
        }
        return total
    }
}
