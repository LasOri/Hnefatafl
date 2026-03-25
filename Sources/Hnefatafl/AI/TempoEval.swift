enum TempoEval {
    static func tempoAdvantage(position: Position, player: Player) -> Int {
        let myMoves = position.allLegalMoves(for: player).count
        let opponent: Player = player == .attacker ? .defender : .attacker
        let theirMoves = position.allLegalMoves(for: opponent).count
        guard theirMoves > 0 else { return 100 }
        return (myMoves * 100) / theirMoves - 100
    }

    static func hasTempo(position: Position, player: Player) -> Bool {
        tempoAdvantage(position: position, player: player) > 0
    }
}
