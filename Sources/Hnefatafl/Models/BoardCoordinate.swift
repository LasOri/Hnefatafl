struct BoardCoordinate: Equatable {
    let row: Int
    let col: Int

    var isValid: Bool {
        row >= 0 && row < Position.boardSize && col >= 0 && col < Position.boardSize
    }

    var isCorner: Bool {
        (row == 0 || row == 10) && (col == 0 || col == 10)
    }

    var isThrone: Bool {
        row == 5 && col == 5
    }

    var isEdge: Bool {
        guard !isCorner else { return false }
        return row == 0 || row == 10 || col == 0 || col == 10
    }

    private static let columns = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]

    var algebraic: String {
        guard isValid else { return "??" }
        return "\(BoardCoordinate.columns[col])\(Position.boardSize - row)"
    }

    func manhattanDistance(to other: BoardCoordinate) -> Int {
        abs(row - other.row) + abs(col - other.col)
    }

    static var allCoordinates: [BoardCoordinate] {
        (0..<Position.boardSize).flatMap { row in
            (0..<Position.boardSize).map { col in
                BoardCoordinate(row: row, col: col)
            }
        }
    }
}
