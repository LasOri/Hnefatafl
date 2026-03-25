struct InfluenceMap: Equatable {
    let values: [Int]

    func value(row: Int, col: Int) -> Int {
        values[row * Position.boardSize + col]
    }

    var totalInfluence: Int {
        values.reduce(0, +)
    }
}

enum InfluenceMapBuilder {
    static func build(position: Position, player: Player) -> InfluenceMap {
        var vals = Array(repeating: 0, count: Position.boardSize * Position.boardSize)
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col) else { continue }
                let isP: Bool
                switch piece {
                case .attacker: isP = player == .attacker
                case .defender, .king: isP = player == .defender
                }
                guard isP else { continue }
                for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                    var r = row + dr
                    var c = col + dc
                    var dist = 1
                    while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize && dist <= 3 {
                        if position.pieceAt(row: r, col: c) != nil { break }
                        vals[r * Position.boardSize + c] += max(0, 4 - dist)
                        r += dr
                        c += dc
                        dist += 1
                    }
                }
            }
        }
        return InfluenceMap(values: vals)
    }
}
