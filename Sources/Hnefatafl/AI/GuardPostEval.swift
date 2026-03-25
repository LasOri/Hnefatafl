enum GuardPostEval {
    static func guardedSquares(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var count = 0

        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            if position.pieceAt(row: r, col: c) == .defender {
                count += 1
            }
        }

        return count
    }

    static func guardQuality(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        var score = 0

        for (dr, dc) in directions {
            let r = kingPos.row + dr
            let c = kingPos.col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            if position.pieceAt(row: r, col: c) == .defender {
                let edgeBonus = isEdgeAdjacent(row: r, col: c) ? 5 : 0
                let supportBonus = hasSupportingDefender(row: r, col: c, kingRow: kingPos.row, kingCol: kingPos.col, position: position) ? 10 : 0
                score += 15 + edgeBonus + supportBonus
            }
        }

        return score
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

    private static func isEdgeAdjacent(row: Int, col: Int) -> Bool {
        row == 0 || row == Position.boardSize - 1 || col == 0 || col == Position.boardSize - 1
    }

    private static func hasSupportingDefender(row: Int, col: Int, kingRow: Int, kingCol: Int, position: Position) -> Bool {
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dr, dc) in directions {
            let r = row + dr
            let c = col + dc
            guard r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize else { continue }
            if r == kingRow && c == kingCol { continue }
            if position.pieceAt(row: r, col: c) == .defender {
                return true
            }
        }
        return false
    }
}
