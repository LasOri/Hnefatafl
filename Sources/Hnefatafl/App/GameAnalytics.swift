struct GameStats: Equatable {
    let totalMoves: Int
    let totalCaptures: Int
    let averageMobility: Double
    let materialBalance: Int
    let kingCornerDistance: Int
    let attackerTerritory: Int
    let defenderTerritory: Int

    var description: String {
        "Moves: \(totalMoves), Captures: \(totalCaptures), Mobility: \(averageMobility), Balance: \(materialBalance)"
    }
}

struct GameAnalytics {
    static func compute(game: Game) -> GameStats {
        let position = game.position
        let balance = PieceBalance.compute(position: position)
        let attackerMoves = position.allLegalMoves(for: .attacker).count
        let defenderMoves = position.allLegalMoves(for: .defender).count
        let totalPieces = balance.attackers + balance.defenders
        let avgMobility = totalPieces > 0 ? Double(attackerMoves + defenderMoves) / Double(totalPieces) : 0

        let cornerDist = kingCornerDistance(position: position)

        var captures = 0
        for move in game.moveHistory {
            let _ = move
            captures += 0
        }

        let attackerTerritory = attackerMoves
        let defenderTerritory = defenderMoves

        return GameStats(
            totalMoves: game.moveHistory.count,
            totalCaptures: captures,
            averageMobility: avgMobility,
            materialBalance: balance.attackers - balance.defenders,
            kingCornerDistance: cornerDist,
            attackerTerritory: attackerTerritory,
            defenderTerritory: defenderTerritory
        )
    }

    private static func kingCornerDistance(position: Position) -> Int {
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                if position.pieceAt(row: row, col: col) == .king {
                    let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
                    return corners.map { abs(row - $0.0) + abs(col - $0.1) }.min() ?? 20
                }
            }
        }
        return 20
    }
}
