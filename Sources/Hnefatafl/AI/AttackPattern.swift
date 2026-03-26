enum AttackPatternType: Equatable {
    case encirclement
    case siege
    case flanking
    case scattered
    case none
}

enum AttackPattern {
    static func classify(position: Position) -> AttackPatternType {
        var kingRow = -1
        var kingCol = -1
        var attackerPositions: [(Int, Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                switch position.pieceAt(row: row, col: col) {
                case .king:
                    kingRow = row
                    kingCol = col
                case .attacker:
                    attackerPositions.append((row, col))
                default: break
                }
            }
        }

        guard kingRow >= 0 else { return .none }
        guard !attackerPositions.isEmpty else { return .none }

        let distances = attackerPositions.map { abs($0.0 - kingRow) + abs($0.1 - kingCol) }
        let avgDistance = Double(distances.reduce(0, +)) / Double(distances.count)
        let closeCount = distances.filter { $0 <= 2 }.count

        if closeCount >= 4 { return .siege }

        let quadrants = attackerQuadrants(attackers: attackerPositions, kingRow: kingRow, kingCol: kingCol)
        let occupiedQuadrants = quadrants.filter { $0 > 0 }.count

        if occupiedQuadrants >= 4 && attackerPositions.count >= 12 { return .encirclement }

        if occupiedQuadrants <= 2 && attackerPositions.count >= 3 {
            let allAbove = attackerPositions.allSatisfy { $0.0 < kingRow }
            let allBelow = attackerPositions.allSatisfy { $0.0 > kingRow }
            let allLeft = attackerPositions.allSatisfy { $0.1 < kingCol }
            let allRight = attackerPositions.allSatisfy { $0.1 > kingCol }
            if allAbove || allBelow || allLeft || allRight { return .flanking }
        }

        if avgDistance > 4.0 { return .scattered }

        return .scattered
    }

    private static func attackerQuadrants(attackers: [(Int, Int)], kingRow: Int, kingCol: Int) -> [Int] {
        var counts = [0, 0, 0, 0]
        for (r, c) in attackers {
            let above = r < kingRow
            let left = c < kingCol
            if above && left { counts[0] += 1 }
            else if above && !left { counts[1] += 1 }
            else if !above && left { counts[2] += 1 }
            else { counts[3] += 1 }
        }
        return counts
    }
}
