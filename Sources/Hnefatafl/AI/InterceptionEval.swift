enum InterceptionEval {
    static func interceptorCount(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }

        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    if row == kingPos.row || col == kingPos.col {
                        count += 1
                    }
                }
            }
        }

        return count
    }

    static func interceptionScore(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else { return 0 }

        var score = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    if row == kingPos.row {
                        let distance = abs(col - kingPos.col)
                        score += max(0, 12 - distance * 2)
                    } else if col == kingPos.col {
                        let distance = abs(row - kingPos.row)
                        score += max(0, 12 - distance * 2)
                    }
                }
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
}
