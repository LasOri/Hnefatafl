struct ParsedMove: Equatable {
    let fromRow: Int
    let fromCol: Int
    let toRow: Int
    let toCol: Int
}

enum NotationParser {
    static func parse(_ notation: String) -> ParsedMove? {
        let parts = notation.split(separator: "-")
        guard parts.count == 2 else { return nil }
        guard let from = parseSquare(String(parts[0])),
              let to = parseSquare(String(parts[1])) else { return nil }
        return ParsedMove(fromRow: from.row, fromCol: from.col, toRow: to.row, toCol: to.col)
    }

    private static func parseSquare(_ s: String) -> (row: Int, col: Int)? {
        guard s.count >= 2 else { return nil }
        let chars = Array(s)
        guard let colVal = chars[0].asciiValue, colVal >= 97, colVal <= 107 else { return nil }
        let col = Int(colVal) - 97
        guard let rowNum = Int(String(chars[1...])),
              rowNum >= 1, rowNum <= Position.boardSize else { return nil }
        let row = Position.boardSize - rowNum
        return (row, col)
    }
}
