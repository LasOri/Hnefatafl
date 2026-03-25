struct BoardLayoutData: Equatable {
    let boardSize: Int
    let squareSize: Double
    let totalWidth: Double
    let totalHeight: Double
}

enum BoardDimensions {
    static func layout(containerWidth: Double, padding: Double = 10) -> BoardLayoutData {
        let available = containerWidth - padding * 2
        let squareSize = available / Double(Position.boardSize)
        let total = squareSize * Double(Position.boardSize) + padding * 2
        return BoardLayoutData(
            boardSize: Position.boardSize,
            squareSize: squareSize,
            totalWidth: total,
            totalHeight: total
        )
    }
}
