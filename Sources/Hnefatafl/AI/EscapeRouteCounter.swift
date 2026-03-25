enum EscapeRouteCounter {
    static func count(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var routes = 0
        for (cr, cc) in corners {
            if canReachCorner(from: kingPos, to: (cr, cc), position: position) { routes += 1 }
        }
        return routes
    }

    private static func canReachCorner(
        from: (row: Int, col: Int), to: (Int, Int), position: Position
    ) -> Bool {
        if from.row == to.0 {
            let minC = min(from.col, to.1)
            let maxC = max(from.col, to.1)
            for c in minC...maxC {
                if c == from.col { continue }
                if position.pieceAt(row: from.row, col: c) != nil { return false }
            }
            return true
        }
        if from.col == to.1 {
            let minR = min(from.row, to.0)
            let maxR = max(from.row, to.0)
            for r in minR...maxR {
                if r == from.row { continue }
                if position.pieceAt(row: r, col: from.col) != nil { return false }
            }
            return true
        }
        return false
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
