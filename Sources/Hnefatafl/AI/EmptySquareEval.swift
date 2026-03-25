enum EmptySquareEval {
    static func emptyNearKing(position: Position) -> Int {
        guard let king = findKing(position) else { return 0 }
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == nil {
                    let dist = abs(row - king.row) + abs(col - king.col)
                    if dist > 0 && dist <= 2 { count += 1 }
                }
            }
        }
        return count
    }

    static func strategicEmptySquares(position: Position) -> Int {
        guard let king = findKing(position) else { return 0 }
        let corners = [(0, 0), (0, Position.boardSize - 1),
                       (Position.boardSize - 1, 0), (Position.boardSize - 1, Position.boardSize - 1)]
        var count = 0
        for (cr, cc) in corners {
            let onRow = king.row == cr
            let onCol = king.col == cc
            if onRow {
                let minC = min(king.col, cc)
                let maxC = max(king.col, cc)
                for c in minC...maxC {
                    if position.pieceAt(row: king.row, col: c) == nil { count += 1 }
                }
            }
            if onCol {
                let minR = min(king.row, cr)
                let maxR = max(king.row, cr)
                for r in minR...maxR {
                    if position.pieceAt(row: r, col: king.col) == nil { count += 1 }
                }
            }
            if !onRow && !onCol {
                if position.pieceAt(row: king.row, col: cc) == nil { count += 1 }
                if position.pieceAt(row: cr, col: king.col) == nil { count += 1 }
            }
        }
        return count
    }

    private static func findKing(_ position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }
}
