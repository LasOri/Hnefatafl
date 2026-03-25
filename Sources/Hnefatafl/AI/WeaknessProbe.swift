enum WeaknessProbe {
    static func weaknesses(position: Position, player: Player) -> Int {
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        let enemyPieces: [Piece] = player == .attacker ? [.defender, .king] : [.attacker]
        var count = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                guard let piece = position.pieceAt(row: row, col: col), targetPieces.contains(piece) else {
                    continue
                }

                if isWeak(row: row, col: col, position: position, enemyPieces: enemyPieces) {
                    count += 1
                }
            }
        }

        return count
    }

    static func criticalWeakness(position: Position, player: Player) -> Bool {
        if player == .defender {
            guard let kingPos = findKing(position: position) else {
                return true
            }

            let kingAdj = adjacentSquares(row: kingPos.row, col: kingPos.col)
            let enemyNeighbors = kingAdj.filter { pos in
                if let p = position.pieceAt(row: pos.0, col: pos.1) {
                    return p == .attacker
                }
                return false
            }

            if enemyNeighbors.count >= 3 {
                return true
            }
        }

        let weakCount = weaknesses(position: position, player: player)
        let totalPieces = countPieces(position: position, player: player)

        guard totalPieces > 0 else { return true }

        return weakCount * 2 > totalPieces
    }

    private static func isWeak(row: Int, col: Int, position: Position, enemyPieces: [Piece]) -> Bool {
        let adj = adjacentSquares(row: row, col: col)
        let enemyCount = adj.filter { pos in
            if let p = position.pieceAt(row: pos.0, col: pos.1) {
                return enemyPieces.contains(p)
            }
            return false
        }.count

        let allyCount = adj.count - enemyCount - adj.filter { pos in
            position.pieceAt(row: pos.0, col: pos.1) == nil
        }.count

        return enemyCount >= 1 && allyCount == 0
    }

    private static func adjacentSquares(row: Int, col: Int) -> [(Int, Int)] {
        return [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)].filter { pos in
            pos.0 >= 0 && pos.0 < Position.boardSize && pos.1 >= 0 && pos.1 < Position.boardSize
        }
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

    private static func countPieces(position: Position, player: Player) -> Int {
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        var count = 0
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), targetPieces.contains(piece) {
                    count += 1
                }
            }
        }
        return count
    }
}
