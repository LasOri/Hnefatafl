struct HighlightSquare: Equatable {
    let row: Int
    let col: Int
    let type: HighlightType
}

enum HighlightType: Equatable {
    case selected
    case legalMove
    case lastMove
    case threatened
}

enum BoardHighlightLayer {
    static func highlights(selectedRow: Int?, selectedCol: Int?, lastMove: Move?, position: Position) -> [HighlightSquare] {
        var result: [HighlightSquare] = []

        if let row = selectedRow, let col = selectedCol {
            result.append(HighlightSquare(row: row, col: col, type: .selected))
            let moves = position.legalMoves(forPieceAtRow: row, col: col)
            for move in moves {
                result.append(HighlightSquare(row: move.toRow, col: move.toCol, type: .legalMove))
            }
        }

        if let last = lastMove {
            result.append(HighlightSquare(row: last.fromRow, col: last.fromCol, type: .lastMove))
            result.append(HighlightSquare(row: last.toRow, col: last.toCol, type: .lastMove))
        }

        return result
    }
}
