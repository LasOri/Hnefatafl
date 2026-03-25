enum SafeSquareEval {
    static func safeSquares(position: Position) -> [(row: Int, col: Int)] {
        guard let kingPos = findKing(position: position) else { return [] }

        var result: [(row: Int, col: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if row == kingPos.row && col == kingPos.col { continue }
                guard position.pieceAt(row: row, col: col) == nil else { continue }
                if isSquareSafe(row: row, col: col, position: position) {
                    result.append((row: row, col: col))
                }
            }
        }

        return result
    }

    static func safeSquareCount(position: Position) -> Int {
        safeSquares(position: position).count
    }

    private static func isSquareSafe(row: Int, col: Int, position: Position) -> Bool {
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for (dr, dc) in directions {
            var r = row + dr
            var c = col + dc
            while r >= 0, r < Position.boardSize, c >= 0, c < Position.boardSize {
                if let piece = position.pieceAt(row: r, col: c) {
                    if piece == .attacker { return false }
                    break
                }
                r += dr
                c += dc
            }
        }

        return true
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
