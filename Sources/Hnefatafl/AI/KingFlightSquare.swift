enum KingFlightSquare {
    static func flightSquares(position: Position) -> [(row: Int, col: Int)] {
        guard let kingPos = findKing(position: position) else { return [] }
        let kingMoves = position.legalMoves(forPieceAtRow: kingPos.row, col: kingPos.col)
        var safeSquares: [(row: Int, col: Int)] = []

        for move in kingMoves {
            if !isUnderAttack(row: move.toRow, col: move.toCol, position: position) {
                safeSquares.append((row: move.toRow, col: move.toCol))
            }
        }
        return safeSquares
    }

    static func flightSquareCount(position: Position) -> Int {
        flightSquares(position: position).count
    }

    private static func isUnderAttack(row: Int, col: Int, position: Position) -> Bool {
        let size = Position.boardSize
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dr, dc) in directions {
            var r = row + dr
            var c = col + dc
            while r >= 0, r < size, c >= 0, c < size {
                if let piece = position.pieceAt(row: r, col: c) {
                    if piece == .attacker { return true }
                    break
                }
                r += dr
                c += dc
            }
        }
        return false
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
