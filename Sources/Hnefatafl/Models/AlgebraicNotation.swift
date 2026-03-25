enum AlgebraicNotation {
    private static let columns = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]

    static func squareName(row: Int, col: Int) -> String {
        guard col >= 0, col < 11, row >= 0, row < 11 else { return "?" }
        let letter = columns[col]
        let number = 11 - row
        return "\(letter)\(number)"
    }

    static func parseSquare(_ notation: String) -> (row: Int, col: Int)? {
        guard notation.count >= 2 else { return nil }
        let letter = String(notation.prefix(1))
        guard let col = columns.firstIndex(of: letter) else { return nil }
        let numberStr = String(notation.dropFirst())
        guard let number = Int(numberStr), number >= 1, number <= 11 else { return nil }
        let row = 11 - number
        return (row: row, col: col)
    }

    static func formatMove(_ move: Move) -> String {
        let from = squareName(row: move.fromRow, col: move.fromCol)
        let to = squareName(row: move.toRow, col: move.toCol)
        return "\(from)-\(to)"
    }

    static func parseMove(_ notation: String) -> Move? {
        let parts = notation.split(separator: "-")
        guard parts.count == 2 else { return nil }
        guard let from = parseSquare(String(parts[0])) else { return nil }
        guard let to = parseSquare(String(parts[1])) else { return nil }
        return Move(fromRow: from.row, fromCol: from.col, toRow: to.row, toCol: to.col)
    }
}
