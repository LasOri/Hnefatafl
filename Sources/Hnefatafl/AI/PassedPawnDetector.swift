enum PassedPawnDetector {
    static func passedDefenders(position: Position) -> [(row: Int, col: Int)] {
        var result: [(row: Int, col: Int)] = []
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                guard piece == .defender || piece == .king else { continue }
                if hasCornerPath(row: row, col: col, position: position) {
                    result.append((row, col))
                }
            }
        }
        return result
    }

    private static func hasCornerPath(row: Int, col: Int, position: Position) -> Bool {
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        for corner in corners {
            if isPathClear(fromRow: row, fromCol: col, toRow: corner.0, toCol: corner.1, position: position) {
                return true
            }
        }
        return false
    }

    private static func isPathClear(fromRow: Int, fromCol: Int, toRow: Int, toCol: Int, position: Position) -> Bool {
        if fromRow == toRow {
            let minC = min(fromCol, toCol)
            let maxC = max(fromCol, toCol)
            for c in minC...maxC {
                if c == fromCol { continue }
                if let p = position.pieceAt(row: fromRow, col: c), p == .attacker { return false }
            }
            return true
        }
        if fromCol == toCol {
            let minR = min(fromRow, toRow)
            let maxR = max(fromRow, toRow)
            for r in minR...maxR {
                if r == fromRow { continue }
                if let p = position.pieceAt(row: r, col: fromCol), p == .attacker { return false }
            }
            return true
        }
        return false
    }
}
