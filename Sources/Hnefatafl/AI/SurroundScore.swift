enum SurroundScore {
    static func kingSurroundedness(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var score = 0
        for (dr, dc) in [(0,1),(0,-1),(1,0),(-1,0)] {
            let r = kingPos.row + dr, c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { score += 25; continue }
            if position.pieceAt(row: r, col: c) == .attacker { score += 25 }
            else if position.pieceAt(row: r, col: c) != nil { score += 5 }
        }
        return score
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
