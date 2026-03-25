enum EscapeLaneEval {
    static func openLanes(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let size = Position.boardSize
        var lanes = 0

        let rowClear = (0..<size).allSatisfy { col in
            col == kingPos.col || position.pieceAt(row: kingPos.row, col: col) == nil
        }
        if rowClear { lanes += 1 }

        let colClear = (0..<size).allSatisfy { row in
            row == kingPos.row || position.pieceAt(row: row, col: kingPos.col) == nil
        }
        if colClear { lanes += 1 }

        return lanes
    }

    static func laneScore(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let size = Position.boardSize
        var score = 0
        let corners = [(0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1)]

        if isRowClear(position: position, row: kingPos.row, kingCol: kingPos.col) {
            for (_, cc) in corners where cc == 0 || cc == size - 1 {
                let edgeRow = kingPos.row
                if edgeRow == 0 || edgeRow == size - 1 {
                    score += 10
                } else {
                    score += 5
                }
            }
        }

        if isColClear(position: position, col: kingPos.col, kingRow: kingPos.row) {
            for (cr, _) in corners where cr == 0 || cr == size - 1 {
                let edgeCol = kingPos.col
                if edgeCol == 0 || edgeCol == size - 1 {
                    score += 10
                } else {
                    score += 5
                }
            }
        }

        return score
    }

    private static func isRowClear(position: Position, row: Int, kingCol: Int) -> Bool {
        for col in 0..<Position.boardSize {
            if col == kingCol { continue }
            if position.pieceAt(row: row, col: col) != nil { return false }
        }
        return true
    }

    private static func isColClear(position: Position, col: Int, kingRow: Int) -> Bool {
        for row in 0..<Position.boardSize {
            if row == kingRow { continue }
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
