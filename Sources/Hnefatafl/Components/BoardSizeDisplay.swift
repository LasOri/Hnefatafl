struct BoardSizeDisplay: Equatable {
    let rows: Int
    let cols: Int
    let label: String

    var totalSquares: Int { rows * cols }

    static let copenhagen = BoardSizeDisplay(rows: 11, cols: 11, label: "Copenhagen (11×11)")
}
