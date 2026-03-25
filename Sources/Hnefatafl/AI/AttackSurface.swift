enum AttackSurface {
    static func surfaceArea(position: Position) -> Int {
        var count = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .attacker {
                    if hasAdjacentDefender(row: row, col: col, position: position) {
                        count += 1
                    }
                }
            }
        }

        return count
    }

    static func surfaceBalance(position: Position) -> Int {
        var attackerOnSurface = 0
        var defenderOnSurface = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .attacker {
                    if hasAdjacentDefender(row: row, col: col, position: position) {
                        attackerOnSurface += 1
                    }
                } else if piece == .defender || piece == .king {
                    if hasAdjacentAttacker(row: row, col: col, position: position) {
                        defenderOnSurface += 1
                    }
                }
            }
        }

        return attackerOnSurface - defenderOnSurface
    }

    private static func hasAdjacentDefender(row: Int, col: Int, position: Position) -> Bool {
        let neighbors = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
        for n in neighbors {
            if n.0 >= 0 && n.0 < Position.boardSize && n.1 >= 0 && n.1 < Position.boardSize {
                let piece = position.pieceAt(row: n.0, col: n.1)
                if piece == .defender || piece == .king {
                    return true
                }
            }
        }
        return false
    }

    private static func hasAdjacentAttacker(row: Int, col: Int, position: Position) -> Bool {
        let neighbors = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
        for n in neighbors {
            if n.0 >= 0 && n.0 < Position.boardSize && n.1 >= 0 && n.1 < Position.boardSize {
                if position.pieceAt(row: n.0, col: n.1) == .attacker {
                    return true
                }
            }
        }
        return false
    }
}
