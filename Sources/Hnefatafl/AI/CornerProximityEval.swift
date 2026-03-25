enum CornerProximityEval {
    static func evaluate(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        let minKingDist = corners.map { abs(kingPos.row - $0.0) + abs(kingPos.col - $0.1) }.min() ?? 20

        var blockerScore = 0
        for corner in corners {
            let dist = abs(kingPos.row - corner.0) + abs(kingPos.col - corner.1)
            if dist <= 4 {
                blockerScore += countBlockers(position: position, cornerRow: corner.0, cornerCol: corner.1)
            }
        }

        return max(0, 200 - minKingDist * 20) - blockerScore * 30
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king { return (row, col) }
            }
        }
        return nil
    }

    private static func countBlockers(position: Position, cornerRow: Int, cornerCol: Int) -> Int {
        var count = 0
        for dr in -2...2 {
            for dc in -2...2 {
                let r = cornerRow + dr, c = cornerCol + dc
                guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
                if position.pieceAt(row: r, col: c) == .attacker { count += 1 }
            }
        }
        return count
    }
}
