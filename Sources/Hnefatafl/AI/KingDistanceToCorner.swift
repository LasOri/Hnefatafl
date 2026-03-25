enum KingDistanceToCorner {
    static func minDistance(position: Position) -> Int {
        guard let king = findKing(position: position) else { return Int.max }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        return corners.map { abs(king.row - $0.0) + abs(king.col - $0.1) }.min() ?? Int.max
    }

    static func closestCorner(position: Position) -> (row: Int, col: Int)? {
        guard let king = findKing(position: position) else { return nil }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        return corners.min(by: {
            abs(king.row - $0.0) + abs(king.col - $0.1) < abs(king.row - $1.0) + abs(king.col - $1.1)
        })
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
}
