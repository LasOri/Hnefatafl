enum SpacePressure {
    static func openSpaceNearKing(position: Position) -> Int {
        guard let kingPos = findKing(position: position) else {
            return 0
        }

        var count = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let distance = abs(row - kingPos.row) + abs(col - kingPos.col)
                if distance > 0 && distance <= 3 && position.pieceAt(row: row, col: col) == nil {
                    count += 1
                }
            }
        }

        return count
    }

    static func spaceControl(position: Position, player: Player) -> Int {
        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
        var controlled = Set<Int>()

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), targetPieces.contains(piece) {
                    let neighbors = [
                        (row - 1, col), (row + 1, col),
                        (row, col - 1), (row, col + 1)
                    ]
                    for n in neighbors {
                        if n.0 >= 0 && n.0 < Position.boardSize && n.1 >= 0 && n.1 < Position.boardSize {
                            if position.pieceAt(row: n.0, col: n.1) == nil {
                                controlled.insert(n.0 * Position.boardSize + n.1)
                            }
                        }
                    }
                }
            }
        }

        return controlled.count
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
