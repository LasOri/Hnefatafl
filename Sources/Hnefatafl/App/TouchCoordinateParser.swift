struct TouchCoordinateParser {
    static func squareFromPosition(
        x: Double, y: Double,
        boardWidth: Double, boardHeight: Double,
        boardSize: Int
    ) -> (row: Int, col: Int)? {
        guard x >= 0, y >= 0, x < boardWidth, y < boardHeight else {
            return nil
        }
        let cellWidth = boardWidth / Double(boardSize)
        let cellHeight = boardHeight / Double(boardSize)
        let col = Int(x / cellWidth)
        let row = Int(y / cellHeight)
        guard row >= 0, row < boardSize, col >= 0, col < boardSize else {
            return nil
        }
        return (row: row, col: col)
    }
}
