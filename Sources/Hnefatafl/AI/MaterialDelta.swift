enum MaterialDelta {
    static func rawBalance(position: Position) -> Int {
        position.attackerCount - position.defenderCount
    }

    static func weightedBalance(position: Position) -> Int {
        var defenders = 0
        var hasKing = false
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .defender {
                    defenders += 1
                } else if piece == .king {
                    hasKing = true
                }
            }
        }
        let weightedDefenders = defenders + (hasKing ? 3 : 0)
        return position.attackerCount - weightedDefenders
    }
}
