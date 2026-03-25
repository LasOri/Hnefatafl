struct GameExport: Equatable {
    let format: ExportFormatType
    let content: String
}

enum ExportFormatType: String, Equatable {
    case pgn = "PGN"
    case json = "JSON"
    case text = "Text"
}

enum ExportFormat {
    static func exportMoves(moves: [Move], format: ExportFormatType) -> GameExport {
        let content: String
        switch format {
        case .pgn:
            content = moves.enumerated().map { i, m in
                let num = i / 2 + 1
                let prefix = i % 2 == 0 ? "\(num). " : ""
                return "\(prefix)\(squareName(m.fromRow, m.fromCol))-\(squareName(m.toRow, m.toCol))"
            }.joined(separator: " ")
        case .json:
            let items = moves.map { "{\"from\":[\($0.fromRow),\($0.fromCol)],\"to\":[\($0.toRow),\($0.toCol)]}" }
            content = "[\(items.joined(separator: ","))]"
        case .text:
            content = moves.enumerated().map { i, m in
                "\(i+1). \(squareName(m.fromRow, m.fromCol)) -> \(squareName(m.toRow, m.toCol))"
            }.joined(separator: "\n")
        }
        return GameExport(format: format, content: content)
    }

    private static func squareName(_ row: Int, _ col: Int) -> String {
        "\(String(UnicodeScalar(97 + col)!))\(Position.boardSize - row)"
    }
}
