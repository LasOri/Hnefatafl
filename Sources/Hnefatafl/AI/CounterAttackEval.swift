enum CounterAttackEval {
    static func counterAttackMoves(position: Position, player: Player) -> [Move] {
        let allMoves = position.allLegalMoves(for: player)
        var result: [Move] = []

        for move in allMoves {
            let newPosition = position.applyMove(move)
            if createsNewThreat(from: position, to: newPosition, move: move, player: player) {
                result.append(move)
            }
        }

        return result
    }

    static func counterAttackScore(position: Position, player: Player) -> Int {
        counterAttackMoves(position: position, player: player).count * 8
    }

    private static func createsNewThreat(from original: Position, to newPos: Position, move: Move, player: Player) -> Bool {
        let enemyCountBefore = player == .attacker ? original.defenderCount : original.attackerCount
        let enemyCountAfter = player == .attacker ? newPos.defenderCount : newPos.attackerCount

        if enemyCountAfter < enemyCountBefore {
            return true
        }

        let enemy: Piece = player == .attacker ? .defender : .attacker
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        for (dr, dc) in directions {
            let adjRow = move.toRow + dr
            let adjCol = move.toCol + dc
            guard adjRow >= 0, adjRow < Position.boardSize,
                  adjCol >= 0, adjCol < Position.boardSize else { continue }
            if newPos.pieceAt(row: adjRow, col: adjCol) == enemy {
                let behindRow = adjRow + dr
                let behindCol = adjCol + dc
                if behindRow >= 0, behindRow < Position.boardSize,
                   behindCol >= 0, behindCol < Position.boardSize {
                    let behindPiece = newPos.pieceAt(row: behindRow, col: behindCol)
                    if behindPiece != nil && behindPiece != enemy && behindPiece != .king {
                        return true
                    }
                }
            }
        }

        return false
    }
}
