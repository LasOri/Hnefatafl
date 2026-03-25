enum KingProtectionRing {
    static func ringStrength(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let deltas = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        var count = 0
        for (dr, dc) in deltas {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c), piece == .defender {
                count += 1
            }
        }
        return count
    }

    static func ringGaps(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let deltas = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        var count = 0
        for (dr, dc) in deltas {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            if position.pieceAt(row: r, col: c) == nil {
                count += 1
            }
        }
        return count
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        let size = Position.boardSize
        for row in 0..<size {
            for col in 0..<size {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }
}
