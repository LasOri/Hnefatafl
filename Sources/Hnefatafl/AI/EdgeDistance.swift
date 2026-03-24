struct EdgeDistance {
    static func toEdge(row: Int, col: Int) -> Int {
        let size = Position.boardSize
        return min(row, col, size - 1 - row, size - 1 - col)
    }

    static func toCorner(row: Int, col: Int) -> Int {
        let corners = [(0, 0), (0, Position.boardSize - 1), (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        return corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
    }

    static func nearestCorner(row: Int, col: Int) -> (row: Int, col: Int) {
        let size = Position.boardSize
        let corners = [(row: 0, col: 0), (row: 0, col: size - 1), (row: size - 1, col: 0), (row: size - 1, col: size - 1)]
        return corners.min(by: { abs(row - $0.row) + abs(col - $0.col) < abs(row - $1.row) + abs(col - $1.col) })!
    }

    static func kingEscapeDistance(row: Int, col: Int) -> Int {
        toCorner(row: row, col: col)
    }
}
