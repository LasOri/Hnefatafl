enum KingCorridorScan {
    static func clearCorridors(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else {
            return 0
        }

        let corners = [
            (0, 0),
            (0, Position.boardSize - 1),
            (Position.boardSize - 1, 0),
            (Position.boardSize - 1, Position.boardSize - 1)
        ]

        var count = 0

        for corner in corners {
            if isCorridorClear(from: kingPos, to: corner, position: position) {
                count += 1
            }
        }

        return count
    }

    static func bestCorridorLength(position: Position) -> Int? {
        guard let kingPos = findKing(position: position) else {
            return nil
        }

        let corners = [
            (0, 0),
            (0, Position.boardSize - 1),
            (Position.boardSize - 1, 0),
            (Position.boardSize - 1, Position.boardSize - 1)
        ]

        var shortest: Int?

        for corner in corners {
            if isCorridorClear(from: kingPos, to: corner, position: position) {
                let length = abs(kingPos.row - corner.0) + abs(kingPos.col - corner.1)
                if let current = shortest {
                    if length < current {
                        shortest = length
                    }
                } else {
                    shortest = length
                }
            }
        }

        return shortest
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }

    private static func isCorridorClear(from: (row: Int, col: Int), to: (Int, Int), position: Position) -> Bool {
        if from.row == to.0 {
            return isRowClear(row: from.row, fromCol: from.col, toCol: to.1, position: position)
        }

        if from.col == to.1 {
            return isColClear(col: from.col, fromRow: from.row, toRow: to.0, position: position)
        }

        let rowClear = isRowClear(row: from.row, fromCol: from.col, toCol: to.1, position: position)
        let colClearAfterRow = isColClear(col: to.1, fromRow: from.row, toRow: to.0, position: position)
        if rowClear && colClearAfterRow {
            return true
        }

        let colClear = isColClear(col: from.col, fromRow: from.row, toRow: to.0, position: position)
        let rowClearAfterCol = isRowClear(row: to.0, fromCol: from.col, toCol: to.1, position: position)
        if colClear && rowClearAfterCol {
            return true
        }

        return false
    }

    private static func isRowClear(row: Int, fromCol: Int, toCol: Int, position: Position) -> Bool {
        let minCol = min(fromCol, toCol)
        let maxCol = max(fromCol, toCol)
        guard minCol + 1 < maxCol else { return true }
        for col in (minCol + 1)..<maxCol {
            if position.pieceAt(row: row, col: col) != nil {
                return false
            }
        }
        return true
    }

    private static func isColClear(col: Int, fromRow: Int, toRow: Int, position: Position) -> Bool {
        let minRow = min(fromRow, toRow)
        let maxRow = max(fromRow, toRow)
        guard minRow + 1 < maxRow else { return true }
        for row in (minRow + 1)..<maxRow {
            if position.pieceAt(row: row, col: col) != nil {
                return false
            }
        }
        return true
    }
}
