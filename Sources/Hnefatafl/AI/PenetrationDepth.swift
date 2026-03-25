enum PenetrationDepth {
    static func maxPenetration(position: Position) -> Int {
        var maxDepth = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let depth = distanceFromEdge(row: row, col: col)
                    maxDepth = max(maxDepth, depth)
                }
            }
        }
        return maxDepth
    }

    static func averagePenetration(position: Position) -> Double {
        var totalDepth = 0
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    totalDepth += distanceFromEdge(row: row, col: col)
                    count += 1
                }
            }
        }
        guard count > 0 else { return 0 }
        return Double(totalDepth) / Double(count)
    }

    private static func distanceFromEdge(row: Int, col: Int) -> Int {
        let lastIndex = Position.boardSize - 1
        return min(row, col, lastIndex - row, lastIndex - col)
    }
}
