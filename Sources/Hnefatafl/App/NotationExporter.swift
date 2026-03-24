struct NotationExporter {
    static func algebraic(_ move: Move) -> String {
        let from = "\(Position.columnLetter(move.fromCol))\(move.fromRow + 1)"
        let to = "\(Position.columnLetter(move.toCol))\(move.toRow + 1)"
        return "\(from)-\(to)"
    }

    static func exportMoves(_ moves: [Move]) -> String {
        moves.enumerated().map { index, move in
            let number = (index / 2) + 1
            let prefix = index % 2 == 0 ? "\(number). " : ""
            return "\(prefix)\(algebraic(move))"
        }.joined(separator: " ")
    }
}
