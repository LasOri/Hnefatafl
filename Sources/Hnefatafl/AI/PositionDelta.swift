struct PositionChange: Equatable {
    let addedPieces: [(row: Int, col: Int, piece: Piece)]
    let removedPieces: [(row: Int, col: Int, piece: Piece)]

    var totalChanges: Int { addedPieces.count + removedPieces.count }

    static func == (lhs: PositionChange, rhs: PositionChange) -> Bool {
        guard lhs.addedPieces.count == rhs.addedPieces.count else { return false }
        guard lhs.removedPieces.count == rhs.removedPieces.count else { return false }
        for i in 0..<lhs.addedPieces.count {
            let l = lhs.addedPieces[i]
            let r = rhs.addedPieces[i]
            if l.row != r.row || l.col != r.col || l.piece != r.piece { return false }
        }
        for i in 0..<lhs.removedPieces.count {
            let l = lhs.removedPieces[i]
            let r = rhs.removedPieces[i]
            if l.row != r.row || l.col != r.col || l.piece != r.piece { return false }
        }
        return true
    }
}

enum PositionDelta {
    static func diff(from: Position, to: Position) -> PositionChange {
        var added: [(row: Int, col: Int, piece: Piece)] = []
        var removed: [(row: Int, col: Int, piece: Piece)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let oldP = from.pieceAt(row: row, col: col)
                let newP = to.pieceAt(row: row, col: col)
                if oldP != newP {
                    if let o = oldP { removed.append((row, col, o)) }
                    if let n = newP { added.append((row, col, n)) }
                }
            }
        }
        return PositionChange(addedPieces: added, removedPieces: removed)
    }
}
