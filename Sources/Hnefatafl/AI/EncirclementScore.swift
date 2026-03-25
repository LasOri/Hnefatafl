enum EncirclementScore {
    static func score(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var angles = 0
        let dirs: [(Int, Int)] = [(-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1)]
        for (dr, dc) in dirs {
            var r = kingPos.row + dr
            var c = kingPos.col + dc
            while r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize {
                if position.pieceAt(row: r, col: c) == .attacker { angles += 1; break }
                if let p = position.pieceAt(row: r, col: c), p != .attacker { break }
                r += dr; c += dc
            }
        }
        return angles * 12
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
