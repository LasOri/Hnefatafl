enum KingPathComplexity {
    static func complexity(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var minChanges = Int.max

        for corner in corners {
            let changes = directionChanges(from: kingPos, to: corner, position: position)
            if changes < minChanges { minChanges = changes }
        }

        return minChanges == Int.max ? 0 : minChanges
    }

    static func hasDirectPath(position: Position) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]

        for (cr, cc) in corners {
            if canReachStraight(from: kingPos, to: (cr, cc), position: position) {
                return true
            }
        }

        return false
    }

    private static func directionChanges(
        from: (row: Int, col: Int), to: (Int, Int), position: Position
    ) -> Int {
        if canReachStraight(from: from, to: to, position: position) {
            if from.row == to.0 || from.col == to.1 {
                return 0
            }
            return 1
        }

        var bestChanges = Int.max
        let intermediates = [
            (from.row, to.1),
            (to.0, from.col)
        ]

        for mid in intermediates {
            let pathClear1 = isLineClear(from: from, toRow: mid.0, toCol: mid.1, position: position)
            let pathClear2 = isLineClear(from: mid, toRow: to.0, toCol: to.1, position: position)

            if pathClear1 && pathClear2 {
                let changes = (from.row != mid.0 && from.col != mid.1) ? 2 : 1
                if changes < bestChanges { bestChanges = changes }
            }
        }

        return bestChanges == Int.max ? 3 : bestChanges
    }

    private static func canReachStraight(
        from: (row: Int, col: Int), to: (Int, Int), position: Position
    ) -> Bool {
        if from.row == to.0 {
            return isRowClear(row: from.row, fromCol: from.col, toCol: to.1, position: position)
        }
        if from.col == to.1 {
            return isColClear(col: from.col, fromRow: from.row, toRow: to.0, position: position)
        }
        return false
    }

    private static func isLineClear(
        from: (Int, Int), toRow: Int, toCol: Int, position: Position
    ) -> Bool {
        if from.0 == toRow {
            return isRowClear(row: from.0, fromCol: from.1, toCol: toCol, position: position)
        }
        if from.1 == toCol {
            return isColClear(col: from.1, fromRow: from.0, toRow: toRow, position: position)
        }
        return false
    }

    private static func isRowClear(row: Int, fromCol: Int, toCol: Int, position: Position) -> Bool {
        let minC = min(fromCol, toCol)
        let maxC = max(fromCol, toCol)
        for c in minC...maxC {
            if c == fromCol { continue }
            if position.pieceAt(row: row, col: c) != nil { return false }
        }
        return true
    }

    private static func isColClear(col: Int, fromRow: Int, toRow: Int, position: Position) -> Bool {
        let minR = min(fromRow, toRow)
        let maxR = max(fromRow, toRow)
        for r in minR...maxR {
            if r == fromRow { continue }
            if position.pieceAt(row: r, col: col) != nil { return false }
        }
        return true
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
