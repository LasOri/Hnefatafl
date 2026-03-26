enum AttackFormationType: Equatable {
    case line
    case wedge
    case scattered
    case none
}

enum AttackFormation {
    static func classify(position: Position) -> AttackFormationType {
        var positions: [(Int, Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    positions.append((row, col))
                }
            }
        }

        guard !positions.isEmpty else { return .none }
        guard positions.count >= 3 else { return .scattered }

        var rowCounts = Array(repeating: 0, count: Position.boardSize)
        var colCounts = Array(repeating: 0, count: Position.boardSize)
        for p in positions {
            rowCounts[p.0] += 1
            colCounts[p.1] += 1
        }

        let maxRow = rowCounts.max() ?? 0
        let maxCol = colCounts.max() ?? 0
        if maxRow >= 4 || maxCol >= 4 {
            return .line
        }

        var adjacentCount = 0
        for i in 0..<positions.count {
            for j in (i + 1)..<positions.count {
                let dist = abs(positions[i].0 - positions[j].0) + abs(positions[i].1 - positions[j].1)
                if dist == 1 { adjacentCount += 1 }
            }
        }

        if adjacentCount >= 3 {
            return .wedge
        }

        return .scattered
    }
}
