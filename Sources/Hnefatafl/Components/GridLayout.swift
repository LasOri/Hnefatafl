struct GridCell: Equatable {
    let row: Int
    let col: Int
    let x: Double
    let y: Double
    let size: Double
}

enum GridLayout {
    static func cells(squareSize: Double, padding: Double = 0) -> [GridCell] {
        var result: [GridCell] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let x = padding + Double(col) * squareSize
                let y = padding + Double(row) * squareSize
                result.append(GridCell(row: row, col: col, x: x, y: y, size: squareSize))
            }
        }
        return result
    }
}
