struct PieceChange: Equatable {
    let piece: Piece
    let row: Int
    let col: Int
}

struct PositionDiffResult: Equatable {
    let added: [PieceChange]
    let removed: [PieceChange]

    var changedSquareCount: Int {
        added.count + removed.count
    }

    var hasChanges: Bool {
        !added.isEmpty || !removed.isEmpty
    }
}

enum PositionDiff {
    static func compare(before: Position, after: Position) -> PositionDiffResult {
        var added: [PieceChange] = []
        var removed: [PieceChange] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let beforePiece = before.pieceAt(row: row, col: col)
                let afterPiece = after.pieceAt(row: row, col: col)

                if beforePiece != afterPiece {
                    if let piece = beforePiece {
                        removed.append(PieceChange(piece: piece, row: row, col: col))
                    }
                    if let piece = afterPiece {
                        added.append(PieceChange(piece: piece, row: row, col: col))
                    }
                }
            }
        }

        return PositionDiffResult(added: added, removed: removed)
    }
}
