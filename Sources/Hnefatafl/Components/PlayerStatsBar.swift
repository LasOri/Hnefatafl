struct PlayerStats: Equatable {
    let pieceCount: Int
    let capturedCount: Int
    let mobilityScore: Int
}

enum PlayerStatsBar {
    static func stats(for player: Player, position: Position, initialPieceCount: Int) -> PlayerStats {
        let currentCount: Int
        switch player {
        case .attacker: currentCount = position.attackerCount
        case .defender: currentCount = position.defenderCount
        }
        let captured = max(0, initialPieceCount - currentCount)
        let mobility = position.allLegalMoves(for: player).count
        return PlayerStats(pieceCount: currentCount, capturedCount: captured, mobilityScore: mobility)
    }
}
