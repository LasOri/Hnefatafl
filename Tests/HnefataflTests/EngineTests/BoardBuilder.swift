@testable import Hnefatafl

struct BoardBuilder {
    private var cells: [Piece?] = Array(repeating: nil, count: 121)

    func placing(_ piece: Piece, row: Int, col: Int) -> BoardBuilder {
        var copy = self
        copy.cells[row * 11 + col] = piece
        return copy
    }

    func build() -> Position {
        Position(cells: cells)
    }
}

func emptyBoard() -> BoardBuilder {
    BoardBuilder()
}
