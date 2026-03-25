enum CellAppearance: String, CaseIterable, Equatable {
    case normal
    case highlighted
    case selected
    case threatened
}

struct BoardCellStyle: Equatable {
    let appearance: CellAppearance
    let isCorner: Bool
    let isThrone: Bool

    static func style(row: Int, col: Int) -> BoardCellStyle {
        let lastIndex = Position.boardSize - 1
        let isCorner = (row == 0 || row == lastIndex) && (col == 0 || col == lastIndex)
        let center = Position.boardSize / 2
        let isThrone = row == center && col == center

        return BoardCellStyle(
            appearance: .normal,
            isCorner: isCorner,
            isThrone: isThrone
        )
    }
}
