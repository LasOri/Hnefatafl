struct StrategicValueMap: Equatable {
    private let values: [[Int]]

    static let standard = StrategicValueMap()

    init() {
        var grid = Array(repeating: Array(repeating: 0, count: Position.boardSize), count: Position.boardSize)

        let mid = Position.boardSize / 2
        grid[mid][mid] = 100

        let corners = [(0, 0), (0, Position.boardSize - 1), (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        for corner in corners {
            grid[corner.0][corner.1] = 100
        }

        for row in 0..<Position.boardSize {
            grid[row][0] = 50
            grid[row][Position.boardSize - 1] = 50
        }
        for col in 0..<Position.boardSize {
            grid[0][col] = 50
            grid[Position.boardSize - 1][col] = 50
        }

        for corner in corners {
            grid[corner.0][corner.1] = 100
        }
        grid[mid][mid] = 100

        for row in 1..<Position.boardSize - 1 {
            for col in 1..<Position.boardSize - 1 {
                if grid[row][col] == 0 {
                    let distToEdge = min(row, col, Position.boardSize - 1 - row, Position.boardSize - 1 - col)
                    grid[row][col] = distToEdge * 5
                }
            }
        }

        self.values = grid
    }

    func value(row: Int, col: Int) -> Int {
        guard row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize else {
            return 0
        }
        return values[row][col]
    }
}
