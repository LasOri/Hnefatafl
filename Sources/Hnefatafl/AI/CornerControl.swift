enum CornerControl {
    static func cornerAttackerPresence(position: Position) -> Int {
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var score = 0
        for (cr, cc) in corners {
            for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                let r = cr + dr, c = cc + dc
                guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                if position.pieceAt(row: r, col: c) == .attacker { score += 1 }
            }
        }
        return score
    }

    static func isCornerBlocked(position: Position, cornerRow: Int, cornerCol: Int) -> Bool {
        for (dr, dc) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            let r = cornerRow + dr, c = cornerCol + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if position.pieceAt(row: r, col: c) == .attacker { return true }
        }
        return false
    }
}
