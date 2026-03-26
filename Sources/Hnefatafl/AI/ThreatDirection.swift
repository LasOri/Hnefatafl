enum CardinalDirection: Equatable {
    case north, south, east, west
}

enum ThreatDirection {
    static func analyze(position: Position, row: Int, col: Int) -> [CardinalDirection] {
        guard let piece = position.pieceAt(row: row, col: col) else { return [] }

        let isAttacker = piece == .attacker
        var directions: [CardinalDirection] = []

        let checks: [(Int, Int, CardinalDirection)] = [
            (-1, 0, .north), (1, 0, .south), (0, -1, .west), (0, 1, .east)
        ]

        for (dr, dc, dir) in checks {
            let r = row + dr
            let c = col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            let adj = position.pieceAt(row: r, col: c)
            if isAttacker && (adj == .defender || adj == .king) {
                directions.append(dir)
            } else if !isAttacker && adj == .attacker {
                directions.append(dir)
            }
        }

        return directions
    }
}
