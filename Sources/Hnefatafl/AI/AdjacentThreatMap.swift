struct AdjacentThreatMap: Equatable {
    let threats: [Bool]

    func isThreatened(row: Int, col: Int) -> Bool {
        let idx = row * Position.boardSize + col
        guard idx >= 0 && idx < threats.count else { return false }
        return threats[idx]
    }

    var threatenedCount: Int { threats.filter { $0 }.count }
}

enum AdjacentThreatMapBuilder {
    static func build(position: Position, by player: Player) -> AdjacentThreatMap {
        var threats = Array(repeating: false, count: Position.boardSize * Position.boardSize)
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isPlayer: Bool
                switch piece {
                case .attacker: isPlayer = player == .attacker
                case .defender, .king: isPlayer = player == .defender
                }
                guard isPlayer else { continue }
                for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                    let r = row + dr, c = col + dc
                    guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                    threats[r * Position.boardSize + c] = true
                }
            }
        }
        return AdjacentThreatMap(threats: threats)
    }
}
