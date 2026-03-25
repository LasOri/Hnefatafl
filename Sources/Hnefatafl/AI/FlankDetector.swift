enum FlankDetector {
    static func isFlankingKing(position: Position) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        let hasLeft = hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 0, dCol: -1)
        let hasRight = hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 0, dCol: 1)
        let hasAbove = hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: -1, dCol: 0)
        let hasBelow = hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 1, dCol: 0)
        return (hasLeft && hasRight) || (hasAbove && hasBelow)
    }

    static func flankCount(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var count = 0
        if hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 0, dCol: -1) { count += 1 }
        if hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 0, dCol: 1) { count += 1 }
        if hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: -1, dCol: 0) { count += 1 }
        if hasAttackerInDirection(position: position, kingRow: kingPos.row, kingCol: kingPos.col, dRow: 1, dCol: 0) { count += 1 }
        return count
    }

    private static func hasAttackerInDirection(position: Position, kingRow: Int, kingCol: Int, dRow: Int, dCol: Int) -> Bool {
        var r = kingRow + dRow
        var c = kingCol + dCol
        while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
            if position.pieceAt(row: r, col: c) == .attacker { return true }
            if let p = position.pieceAt(row: r, col: c), p == .defender || p == .king { return false }
            r += dRow
            c += dCol
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
