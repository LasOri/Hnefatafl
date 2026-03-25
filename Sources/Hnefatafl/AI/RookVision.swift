enum RookVision {
    static func canSee(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int, position: Position) -> Bool {
        guard fromRow == toRow || fromCol == toCol else { return false }
        if fromRow == toRow {
            let minC = min(fromCol, toCol) + 1
            let maxC = max(fromCol, toCol)
            for c in minC..<maxC {
                if position.pieceAt(row: fromRow, col: c) != nil { return false }
            }
        } else {
            let minR = min(fromRow, toRow) + 1
            let maxR = max(fromRow, toRow)
            for r in minR..<maxR {
                if position.pieceAt(row: r, col: fromCol) != nil { return false }
            }
        }
        return true
    }

    static func visibleSquares(row: Int, col: Int, position: Position) -> Int {
        var count = 0
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            var r = row + dr
            var c = col + dc
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if position.pieceAt(row: r, col: c) != nil { break }
                count += 1
                r += dr
                c += dc
            }
        }
        return count
    }
}
