enum BoardAccessibility {
    static func squareLabel(row: Int, col: Int, position: Position) -> String {
        let colLetter = String(UnicodeScalar(65 + col)!)
        let rowNum = Position.boardSize - row
        let squareName = "\(colLetter)\(rowNum)"

        guard let piece = position.pieceAt(row: row, col: col) else {
            let sqType = Position.squareType(row: row, col: col)
            switch sqType {
            case .throne: return "\(squareName), throne, empty"
            case .corner: return "\(squareName), corner, empty"
            case .regular: return "\(squareName), empty"
            }
        }

        let pieceName: String
        switch piece {
        case .attacker: pieceName = "attacker"
        case .defender: pieceName = "defender"
        case .king: pieceName = "king"
        }
        return "\(squareName), \(pieceName)"
    }

    static func boardSummary(position: Position) -> String {
        "Hnefatafl board, \(position.attackerCount) attackers, \(position.defenderCount) defenders"
    }
}
