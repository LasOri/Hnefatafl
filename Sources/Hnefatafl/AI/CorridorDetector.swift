enum CorridorDetector {
    static func openCorridors(position: Position) -> [(isRow: Bool, index: Int)] {
        var corridors: [(isRow: Bool, index: Int)] = []
        guard let kingPos = findKing(position: position) else { return corridors }
        for row in 0..<Position.boardSize {
            if isRowOpen(position: position, row: row, kingRow: kingPos.row, kingCol: kingPos.col) {
                corridors.append((isRow: true, index: row))
            }
        }
        for col in 0..<Position.boardSize {
            if isColOpen(position: position, col: col, kingRow: kingPos.row, kingCol: kingPos.col) {
                corridors.append((isRow: false, index: col))
            }
        }
        return corridors
    }

    static func corridorCount(position: Position) -> Int {
        openCorridors(position: position).count
    }

    private static func isRowOpen(position: Position, row: Int, kingRow: Int, kingCol: Int) -> Bool {
        guard row == kingRow else { return false }
        let touchesEdge = row == 0 || row == Position.boardSize - 1
        guard touchesEdge || kingCol == 0 || kingCol == Position.boardSize - 1 else {
            var leftClear = true
            for c in 0..<kingCol {
                if position.pieceAt(row: row, col: c) != nil { leftClear = false; break }
            }
            var rightClear = true
            for c in (kingCol + 1)..<Position.boardSize {
                if position.pieceAt(row: row, col: c) != nil { rightClear = false; break }
            }
            return leftClear || rightClear
        }
        for col in 0..<Position.boardSize {
            if row == kingRow && col == kingCol { continue }
            if position.pieceAt(row: row, col: col) != nil { return false }
        }
        return true
    }

    private static func isColOpen(position: Position, col: Int, kingRow: Int, kingCol: Int) -> Bool {
        guard col == kingCol else { return false }
        let touchesEdge = col == 0 || col == Position.boardSize - 1
        guard touchesEdge || kingRow == 0 || kingRow == Position.boardSize - 1 else {
            var topClear = true
            for r in 0..<kingRow {
                if position.pieceAt(row: r, col: col) != nil { topClear = false; break }
            }
            var bottomClear = true
            for r in (kingRow + 1)..<Position.boardSize {
                if position.pieceAt(row: r, col: col) != nil { bottomClear = false; break }
            }
            return topClear || bottomClear
        }
        for row in 0..<Position.boardSize {
            if row == kingRow && col == kingCol { continue }
            if position.pieceAt(row: row, col: col) != nil { return false }
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
