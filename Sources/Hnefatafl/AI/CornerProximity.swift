struct CornerProximity {
    static let maxScore = 20

    static func score(position: Position) -> Int {
        let size = Position.boardSize
        for i in 0..<(size * size) {
            if position.cells[i] == .king {
                let row = i / size
                let col = i % size
                let distance = nearestCornerDistance(row: row, col: col)
                return max(0, maxScore - distance)
            }
        }
        return 0
    }

    static func nearestCornerDistance(row: Int, col: Int) -> Int {
        let size = Position.boardSize
        let corners = [(0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1)]
        return corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
    }
}
