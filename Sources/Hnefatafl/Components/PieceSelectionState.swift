struct PieceSelectionState: Equatable {
    let selectedRow: Int?
    let selectedCol: Int?
    let validMoves: [Move]

    var hasSelection: Bool {
        selectedRow != nil && selectedCol != nil
    }

    var selectedPosition: (row: Int, col: Int)? {
        guard let row = selectedRow, let col = selectedCol else { return nil }
        return (row: row, col: col)
    }
}
