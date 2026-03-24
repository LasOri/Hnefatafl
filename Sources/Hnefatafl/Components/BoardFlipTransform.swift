import LINKER

struct BoardFlipTransform {
    static func displayRow(row: Int, flipped: Bool) -> Int {
        flipped ? (Position.boardSize - 1 - row) : row
    }

    static func displayCol(col: Int, flipped: Bool) -> Int {
        flipped ? (Position.boardSize - 1 - col) : col
    }
}
