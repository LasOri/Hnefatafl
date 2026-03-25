struct PositionBuilder {
    private var cells: [Piece?]

    init() {
        cells = Array(repeating: nil, count: 121)
    }

    init(from position: Position) {
        cells = (0..<121).map { i in
            position.pieceAt(row: i / 11, col: i % 11)
        }
    }

    func place(_ piece: Piece, row: Int, col: Int) -> PositionBuilder {
        var copy = self
        copy.cells[row * 11 + col] = piece
        return copy
    }

    func remove(row: Int, col: Int) -> PositionBuilder {
        var copy = self
        copy.cells[row * 11 + col] = nil
        return copy
    }

    func clear() -> PositionBuilder {
        PositionBuilder()
    }

    func placeRow(_ piece: Piece, row: Int, cols: [Int]) -> PositionBuilder {
        var copy = self
        for col in cols {
            copy.cells[row * 11 + col] = piece
        }
        return copy
    }

    var pieceCount: Int {
        cells.compactMap { $0 }.count
    }

    func build() -> Position {
        Position(cells: cells)
    }
}
