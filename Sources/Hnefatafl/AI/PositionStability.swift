enum PositionStability {
    static func stability(position: Position) -> Int {
        let attackerThreats = captureCount(position: position, player: .attacker)
        let defenderThreats = captureCount(position: position, player: .defender)
        let totalThreats = attackerThreats + defenderThreats
        let totalPieces = position.attackerCount + position.defenderCount
        return max(0, totalPieces - totalThreats)
    }

    static func isStable(position: Position) -> Bool {
        captureCount(position: position, player: .attacker) == 0 &&
        captureCount(position: position, player: .defender) == 0
    }

    private static func captureCount(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        let opponent: Player = player == .attacker ? .defender : .attacker
        var count = 0
        for move in moves {
            let after = position.applyMove(move)
            let before = pieceCount(position: position, player: opponent)
            let afterCount = pieceCount(position: after, player: opponent)
            if afterCount < before { count += 1 }
        }
        return count
    }

    private static func pieceCount(position: Position, player: Player) -> Int {
        switch player {
        case .attacker: return position.attackerCount
        case .defender: return position.defenderCount
        }
    }
}
