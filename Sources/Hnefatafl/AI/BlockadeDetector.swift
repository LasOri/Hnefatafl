enum BlockadeDetector {
    static func isKingBlockaded(position: Position) -> Bool {
        guard let kingPos = findKing(position: position) else { return false }
        let moves = position.legalMoves(forPieceAtRow: kingPos.row, col: kingPos.col)
        return moves.isEmpty
    }

    static func blockadeStrength(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var blocked = 0
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            let r = kingPos.row + dr, c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else {
                blocked += 1
                continue
            }
            if position.pieceAt(row: r, col: c) != nil { blocked += 1 }
        }
        return blocked * 25
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
