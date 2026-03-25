enum DoubleAttackEval {
    static func evaluate(position: Position) -> Int {
        let moves = position.allLegalMoves(for: .attacker)
        var count = 0

        for move in moves {
            let newPos = position.applyMove(move)
            let threats = countNewThreats(after: newPos, moveToRow: move.toRow, moveToCol: move.toCol)
            if threats >= 2 {
                count += 1
            }
        }

        return count
    }

    static func hasDoubleAttack(position: Position) -> Bool {
        evaluate(position: position) > 0
    }

    private static func countNewThreats(after position: Position, moveToRow: Int, moveToCol: Int) -> Int {
        let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        var threats = 0

        for (dr, dc) in directions {
            let adjRow = moveToRow + dr
            let adjCol = moveToCol + dc
            guard adjRow >= 0 && adjRow < Position.boardSize && adjCol >= 0 && adjCol < Position.boardSize else {
                continue
            }

            if let piece = position.pieceAt(row: adjRow, col: adjCol),
               (piece == .defender || piece == .king) {
                let behindRow = adjRow + dr
                let behindCol = adjCol + dc
                if behindRow >= 0 && behindRow < Position.boardSize &&
                   behindCol >= 0 && behindCol < Position.boardSize {
                    if position.pieceAt(row: behindRow, col: behindCol) == .attacker {
                        threats += 1
                    }
                }
            }
        }

        return threats
    }
}
