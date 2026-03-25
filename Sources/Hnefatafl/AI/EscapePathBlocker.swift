enum EscapePathBlocker {
    static func blockingPieces(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var blockers = 0
        for (cr, cc) in corners {
            blockers += attackersOnPath(from: kingPos, to: (cr, cc), position: position)
        }
        return blockers
    }

    static func isCornerBlocked(position: Position, cornerRow: Int, cornerCol: Int) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        return attackersOnPath(from: kingPos, to: (cornerRow, cornerCol), position: position) > 0
    }

    private static func attackersOnPath(
        from king: (row: Int, col: Int), to corner: (Int, Int), position: Position
    ) -> Int {
        var count = 0
        if king.row == corner.0 {
            let minC = min(king.col, corner.1)
            let maxC = max(king.col, corner.1)
            for c in minC...maxC where c != king.col {
                if position.pieceAt(row: king.row, col: c) == .attacker { count += 1 }
            }
        }
        if king.col == corner.1 {
            let minR = min(king.row, corner.0)
            let maxR = max(king.row, corner.0)
            for r in minR...maxR where r != king.row {
                if position.pieceAt(row: r, col: king.col) == .attacker { count += 1 }
            }
        }
        return count
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }
}
