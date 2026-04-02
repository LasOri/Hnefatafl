enum MaterialAggregator {
    static func compute(position: Position, player: Player) -> Int {
        // Base material difference
        let attackerCount = position.attackerCount
        let defenderCount = position.defenderCount
        let rawDiff: Int
        switch player {
        case .attacker:
            rawDiff = attackerCount - defenderCount
        case .defender:
            rawDiff = defenderCount - attackerCount
        }

        // Sub-modules contribute additional signals
        let balance = MaterialBalance.balance(position: position)
        let countEval = MaterialCountEval.standardEval(position: position)
        let delta = MaterialDelta.rawBalance(position: position)
        let numerical = NumericalAdvantage.globalAdvantage(position: position)
        let pieceVal = PieceValue.totalValue(position: position, player: player)
        let opponentVal = PieceValue.totalValue(
            position: position,
            player: player.opponent
        )

        // Normalize: balance/delta/numerical are attacker-positive
        let subSignal: Int
        switch player {
        case .attacker:
            subSignal = (balance + countEval + delta + numerical) / 4 + (pieceVal - opponentVal) / 10
        case .defender:
            subSignal = (-balance - countEval - delta - numerical) / 4 + (pieceVal - opponentVal) / 10
        }

        return rawDiff + subSignal / 5
    }
}
