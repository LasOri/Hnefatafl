enum AttackerConvergence {
    static func convergenceScore(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var totalDistance = 0
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    totalDistance += abs(row - kingPos.row) + abs(col - kingPos.col)
                    count += 1
                }
            }
        }
        guard count > 0 else { return 0 }
        let avgDistance = totalDistance / count
        let maxPossible = Position.boardSize * 2
        return max(0, maxPossible - avgDistance)
    }

    static func nearbyAttackers(position: Position, radius: Int) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let dist = abs(row - kingPos.row) + abs(col - kingPos.col)
                    if dist <= radius { count += 1 }
                }
            }
        }
        return count
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
