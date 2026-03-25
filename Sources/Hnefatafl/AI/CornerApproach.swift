enum CornerApproach {
    static func closestCornerDistance(position: Position) -> Int? {
        guard let kingPos = findKing(position: position) else { return nil }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        var minDist = Int.max

        for (cr, cc) in corners {
            let dist = abs(kingPos.row - cr) + abs(kingPos.col - cc)
            if dist < minDist { minDist = dist }
        }

        return minDist
    }

    static func approachScore(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        let maxDist = 20
        var score = 0

        for (cr, cc) in corners {
            let dist = abs(kingPos.row - cr) + abs(kingPos.col - cc)
            let contribution = max(0, maxDist - dist)
            score += contribution * contribution
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
