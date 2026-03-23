struct EventParser {
    static func parseSquareClick(row: String?, col: String?) -> (row: Int, col: Int)? {
        guard let rowStr = row, let colStr = col,
              let r = Int(rowStr), let c = Int(colStr),
              r >= 0, r < Position.boardSize,
              c >= 0, c < Position.boardSize else {
            return nil
        }
        return (row: r, col: c)
    }

    static func parseButtonAction(_ action: String?) -> String? {
        guard let action, !action.isEmpty else { return nil }
        return action
    }
}
