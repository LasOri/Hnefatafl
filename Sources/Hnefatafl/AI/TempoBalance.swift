enum TempoBalance {
    static func tempoAdvantage(position: Position, player: Player) -> Int {
        let playerMoves = position.allLegalMoves(for: player).count
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMoves = position.allLegalMoves(for: opponent).count

        return playerMoves - opponentMoves
    }

    static func hasInitiative(position: Position, player: Player) -> Bool {
        return tempoAdvantage(position: position, player: player) > 0
    }
}
