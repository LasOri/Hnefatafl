enum ConfinementScore {
    static func confinementLevel(position: Position) -> Int {
        let reachable = reachableSquares(position: position)
        let maxReachable = Position.boardSize * Position.boardSize
        guard maxReachable > 0 else { return 100 }
        let freedom = Double(reachable) / Double(maxReachable)
        return max(0, min(100, Int((1.0 - freedom) * 100)))
    }

    static func reachableSquares(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }
        var visited: Set<Int> = []
        let directMoves = position.legalMoves(forPieceAtRow: kingPos.0, col: kingPos.1)
        visited.insert(kingPos.0 * Position.boardSize + kingPos.1)
        for move in directMoves {
            let key = move.toRow * Position.boardSize + move.toCol
            if !visited.contains(key) {
                visited.insert(key)
                let nextPos = position.applyMove(move)
                let secondMoves = nextPos.legalMoves(forPieceAtRow: move.toRow, col: move.toCol)
                for m2 in secondMoves {
                    visited.insert(m2.toRow * Position.boardSize + m2.toCol)
                }
            }
        }
        return visited.count
    }

    private static func findKing(position: Position) -> (Int, Int)? {
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
