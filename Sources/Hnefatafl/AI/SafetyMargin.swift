enum SafetyMargin {
    static func kingMargin(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var minEnemyDist = Int.max
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let dist = abs(row - kingPos.row) + abs(col - kingPos.col)
                    minEnemyDist = min(minEnemyDist, dist)
                }
            }
        }
        return minEnemyDist == Int.max ? 100 : minEnemyDist * 10
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
