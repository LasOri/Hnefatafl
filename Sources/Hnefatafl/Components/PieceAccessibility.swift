enum PieceAccessibility {
    static func pieceLabel(_ piece: Piece) -> String {
        switch piece {
        case .attacker: return "Attacker piece"
        case .defender: return "Defender piece"
        case .king: return "King piece"
        }
    }

    static func squareLabel(row: Int, col: Int) -> String {
        let colName = String(UnicodeScalar(65 + col)!)
        return "\(colName)\(Position.boardSize - row)"
    }

    static func moveLabel(move: Move) -> String {
        "\(squareLabel(row: move.fromRow, col: move.fromCol)) to \(squareLabel(row: move.toRow, col: move.toCol))"
    }
}
