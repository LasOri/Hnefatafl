enum SquareOwnership {
    static func owner(row: Int, col: Int, position: Position) -> Player? {
        guard row >= 0, row < Position.boardSize, col >= 0, col < Position.boardSize else { return nil }
        if position.pieceAt(row: row, col: col) != nil { return nil }
        var closestAttacker = Int.max
        var closestDefender = Int.max
        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                let piece = position.pieceAt(row: r, col: c)
                let dist = abs(r - row) + abs(c - col)
                if piece == .attacker && dist < closestAttacker {
                    closestAttacker = dist
                }
                if (piece == .defender || piece == .king) && dist < closestDefender {
                    closestDefender = dist
                }
            }
        }
        if closestAttacker < closestDefender { return .attacker }
        if closestDefender < closestAttacker { return .defender }
        return nil
    }

    static func ownedSquareCount(position: Position, player: Player) -> Int {
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if owner(row: row, col: col, position: position) == player {
                    count += 1
                }
            }
        }
        return count
    }
}
