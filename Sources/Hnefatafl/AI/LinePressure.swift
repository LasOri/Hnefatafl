enum LinePressure {
    static func rowPressure(position: Position, targetRow: Int) -> Int {
        var count = 0
        for col in 0..<Position.boardSize {
            if position.pieceAt(row: targetRow, col: col) == .attacker { count += 1 }
        }
        return count * 15
    }

    static func colPressure(position: Position, targetCol: Int) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            if position.pieceAt(row: row, col: targetCol) == .attacker { count += 1 }
        }
        return count * 15
    }

    static func totalPressureOnKing(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        return rowPressure(position: position, targetRow: kingPos.row)
             + colPressure(position: position, targetCol: kingPos.col)
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
