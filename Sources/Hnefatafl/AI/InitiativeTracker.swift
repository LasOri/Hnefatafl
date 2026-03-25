enum InitiativeTracker {
    static func hasInitiative(position: Position) -> Player {
        let score = initiativeScore(position: position)
        return score >= 0 ? .attacker : .defender
    }

    static func initiativeScore(position: Position) -> Int {
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count

        let mobilityDiff = attackerMoves - defenderMoves

        let attackerThreats = countThreats(position: position, player: .attacker)
        let defenderThreats = countThreats(position: position, player: .defender)
        let threatDiff = attackerThreats - defenderThreats

        return mobilityDiff + threatDiff * 2
    }

    private static func countThreats(position: Position, player: Player) -> Int {
        let enemyPieces: [Piece] = player == .attacker ? [.defender, .king] : [.attacker]
        var threats = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if let piece = position.pieceAt(row: row, col: col), enemyPieces.contains(piece) {
                    let adjacents = [
                        (row - 1, col), (row + 1, col),
                        (row, col - 1), (row, col + 1)
                    ]
                    let friendlyNeighbors = adjacents.filter { pos in
                        guard pos.0 >= 0 && pos.0 < Position.boardSize && pos.1 >= 0 && pos.1 < Position.boardSize else {
                            return false
                        }
                        let targetPieces: [Piece] = player == .attacker ? [.attacker] : [.defender, .king]
                        if let p = position.pieceAt(row: pos.0, col: pos.1) {
                            return targetPieces.contains(p)
                        }
                        return false
                    }
                    if friendlyNeighbors.count >= 1 {
                        threats += 1
                    }
                }
            }
        }

        return threats
    }
}
