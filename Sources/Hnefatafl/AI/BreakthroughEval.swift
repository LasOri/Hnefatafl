enum BreakthroughEval {
    static func evaluate(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }

        let size = Position.boardSize
        let corners = [(0, 0), (0, size - 1), (size - 1, 0), (size - 1, size - 1)]

        var score = 0

        let kingMoves = position.legalMoves(forPieceAtRow: kingPos.row, col: kingPos.col)
        score += kingMoves.count * 5

        for (cr, cc) in corners {
            let dist = abs(kingPos.row - cr) + abs(kingPos.col - cc)
            score += max(0, (size * 2 - dist) * 3)
        }

        for move in kingMoves {
            for (cr, cc) in corners {
                let distAfter = abs(move.toRow - cr) + abs(move.toCol - cc)
                let distBefore = abs(kingPos.row - cr) + abs(kingPos.col - cc)
                if distAfter < distBefore {
                    score += 15
                }
            }
        }

        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        for (dr, dc) in directions {
            var r = kingPos.row + dr
            var c = kingPos.col + dc
            var clear = true
            while r >= 0 && r < size && c >= 0 && c < size {
                if let piece = position.pieceAt(row: r, col: c), piece.isAttackerSide {
                    clear = false
                    break
                }
                r += dr
                c += dc
            }
            if clear { score += 20 }
        }

        return score
    }

    static func hasBreakthroughPotential(position: Position) -> Bool {
        evaluate(position: position) > 100
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
