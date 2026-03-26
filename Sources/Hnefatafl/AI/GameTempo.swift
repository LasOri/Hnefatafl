struct TempoResult: Equatable {
    let attackerTempo: Int
    let defenderTempo: Int
    let advantage: Player?
}

enum GameTempo {
    static func evaluate(position: Position) -> TempoResult {
        var attackerMobility = 0
        var defenderMobility = 0

        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                let piece = position.pieceAt(row: row, col: col)
                if piece == .attacker {
                    attackerMobility += PieceReach.compute(position: position, row: row, col: col)
                } else if piece == .defender || piece == .king {
                    defenderMobility += PieceReach.compute(position: position, row: row, col: col)
                }
            }
        }

        let advantage: Player?
        if attackerMobility > defenderMobility {
            advantage = .attacker
        } else if defenderMobility > attackerMobility {
            advantage = .defender
        } else {
            advantage = nil
        }

        return TempoResult(attackerTempo: attackerMobility, defenderTempo: defenderMobility, advantage: advantage)
    }
}
