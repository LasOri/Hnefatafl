struct CoordinateLabel: Equatable {
    let text: String
    let position: Int
}

enum BoardCoordinateLabels {
    static func columnLabels() -> [CoordinateLabel] {
        (0..<Position.boardSize).map { col in
            CoordinateLabel(text: String(UnicodeScalar(97 + col)!), position: col)
        }
    }

    static func rowLabels() -> [CoordinateLabel] {
        (0..<Position.boardSize).map { row in
            CoordinateLabel(text: "\(Position.boardSize - row)", position: row)
        }
    }

    static func squareLabel(row: Int, col: Int) -> String {
        let colLetter = String(UnicodeScalar(97 + col)!)
        return "\(colLetter)\(Position.boardSize - row)"
    }
}
