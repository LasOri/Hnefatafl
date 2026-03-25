enum PieceMomentum {
    static func attackerMomentum(position: Position) -> Int {
        let center = Position.boardSize / 2
        var momentum = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .attacker {
                    let moves = position.legalMoves(forPieceAtRow: row, col: col)
                    for move in moves {
                        let distBefore = abs(row - center) + abs(col - center)
                        let distAfter = abs(move.toRow - center) + abs(move.toCol - center)
                        if distAfter < distBefore {
                            momentum += 1
                        } else if distAfter > distBefore {
                            momentum -= 1
                        }
                    }
                }
            }
        }

        return momentum
    }

    static func defenderMomentum(position: Position) -> Int {
        var momentum = 0
        let corners = [
            (0, 0),
            (0, Position.boardSize - 1),
            (Position.boardSize - 1, 0),
            (Position.boardSize - 1, Position.boardSize - 1)
        ]

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .defender || piece == .king {
                    let moves = position.legalMoves(forPieceAtRow: row, col: col)
                    for move in moves {
                        let minDistBefore = corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 0
                        let minDistAfter = corners.map { abs(move.toRow - $0.0) + abs(move.toCol - $0.1) }.min() ?? 0
                        if minDistAfter < minDistBefore {
                            momentum += 1
                        } else if minDistAfter > minDistBefore {
                            momentum -= 1
                        }
                    }
                }
            }
        }

        return momentum
    }
}
