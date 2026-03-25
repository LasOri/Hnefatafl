enum DefenderCohesion {
    static func averageDistanceToKing(position: Position) -> Double {
        guard let kingPos = findKing(position: position) else {
            return 0.0
        }

        var totalDistance = 0
        var defenderCount = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .defender {
                    let distance = abs(row - kingPos.row) + abs(col - kingPos.col)
                    totalDistance += distance
                    defenderCount += 1
                }
            }
        }

        guard defenderCount > 0 else {
            return 0.0
        }

        return Double(totalDistance) / Double(defenderCount)
    }

    static func supportScore(position: Position) -> Int {
        var support = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .defender {
                    let adjacentDefenders = countAdjacentDefenders(row: row, col: col, position: position)
                    support += adjacentDefenders * 10
                }
            }
        }

        return support
    }

    static func total(position: Position) -> Int {
        guard findKing(position: position) != nil else { return 0 }
        let avgDistance = averageDistanceToKing(position: position)
        let distanceScore = max(0, 100 - Int(avgDistance * 10))
        let support = supportScore(position: position)
        return distanceScore + support
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func countAdjacentDefenders(row: Int, col: Int, position: Position) -> Int {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var count = 0

        for (dRow, dCol) in directions {
            let r = row + dRow
            let c = col + dCol

            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                continue
            }

            if position.pieceAt(row: r, col: c) == .defender {
                count += 1
            }
        }

        return count
    }
}
