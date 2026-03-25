enum TargetSquareAnalysis {
    static func topTargets(position: Position, player: Player, count: Int) -> [(row: Int, col: Int)] {
        var scored: [(row: Int, col: Int, value: Int)] = []

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == nil {
                    let value = squareValue(row: row, col: col, position: position, player: player)
                    if value > 0 {
                        scored.append((row, col, value))
                    }
                }
            }
        }

        scored.sort { $0.value > $1.value }
        let limit = min(count, scored.count)
        return scored.prefix(limit).map { ($0.row, $0.col) }
    }

    static func isHighPriorityTarget(row: Int, col: Int, position: Position, player: Player) -> Bool {
        let value = squareValue(row: row, col: col, position: position, player: player)
        return value >= 15
    }

    private static func squareValue(row: Int, col: Int, position: Position, player: Player) -> Int {
        var value = 0
        let center = Position.boardSize / 2

        switch player {
        case .attacker:
            if let kingPos = findKing(position: position) {
                let distToKing = abs(row - kingPos.row) + abs(col - kingPos.col)
                if distToKing <= 2 {
                    value += (3 - distToKing) * 10
                }
            }
            let adjacentEnemies = countAdjacentPieces(row: row, col: col, position: position, target: .defender)
                + countAdjacentPieces(row: row, col: col, position: position, target: .king)
            value += adjacentEnemies * 5

        case .defender:
            let corners = [
                (0, 0),
                (0, Position.boardSize - 1),
                (Position.boardSize - 1, 0),
                (Position.boardSize - 1, Position.boardSize - 1)
            ]
            for corner in corners {
                if row == corner.0 || col == corner.1 {
                    let distToCorner = abs(row - corner.0) + abs(col - corner.1)
                    if distToCorner <= 3 {
                        value += (4 - distToCorner) * 5
                    }
                }
            }
            let distFromCenter = abs(row - center) + abs(col - center)
            value += distFromCenter
        }

        return value
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

    private static func countAdjacentPieces(row: Int, col: Int, position: Position, target: Piece) -> Int {
        let neighbors = [(row - 1, col), (row + 1, col), (row, col - 1), (row, col + 1)]
        var count = 0
        for n in neighbors {
            if n.0 >= 0 && n.0 < Position.boardSize && n.1 >= 0 && n.1 < Position.boardSize {
                if position.pieceAt(row: n.0, col: n.1) == target {
                    count += 1
                }
            }
        }
        return count
    }
}
