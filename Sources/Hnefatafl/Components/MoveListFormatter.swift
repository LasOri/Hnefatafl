enum MoveListFormatter {
    static func format(moves: [Move]) -> [String] {
        moves.enumerated().map { index, move in
            let moveNum = index / 2 + 1
            let prefix = index % 2 == 0 ? "\(moveNum)." : ""
            let from = squareName(row: move.fromRow, col: move.fromCol)
            let to = squareName(row: move.toRow, col: move.toCol)
            return "\(prefix)\(from)-\(to)"
        }
    }

    static func squareName(row: Int, col: Int) -> String {
        let colLetter = String(UnicodeScalar(97 + col)!)
        let rowNumber = Position.boardSize - row
        return "\(colLetter)\(rowNumber)"
    }

    static func formatCompact(moves: [Move]) -> String {
        format(moves: moves).joined(separator: " ")
    }
}
