enum PawnShieldEval {
    static func evaluate(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        let adjacent = shieldCount(position: position)
        var score = adjacent * 30

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c), piece == .attacker {
                score -= 20
            }
        }

        let diagonals = [(-1, -1), (-1, 1), (1, -1), (1, 1)]
        for (dr, dc) in diagonals {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c), piece == .defender {
                score += 10
            }
        }

        return max(0, score)
    }

    static func shieldCount(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var count = 0
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0 && r < Position.boardSize && c >= 0 && c < Position.boardSize else { continue }
            if let piece = position.pieceAt(row: r, col: c), piece == .defender {
                count += 1
            }
        }
        return count
    }

    private static func findKing(position: Position) -> (row: Int, col: Int)? {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    return (row, col)
                }
            }
        }
        return nil
    }
}
