enum PieceExchange {
    static func exchangeBalance(position: Position, player: Player) -> Int {
        let moves = position.allLegalMoves(for: player)
        var bestBalance = 0

        for move in moves {
            let next = position.applyMove(move)
            let attackerDiff = position.attackerCount - next.attackerCount
            let defenderDiff = position.defenderCount - next.defenderCount

            let balance: Int
            switch player {
            case .attacker:
                balance = defenderDiff - attackerDiff
            case .defender:
                balance = attackerDiff - defenderDiff
            }

            if balance > bestBalance { bestBalance = balance }
        }

        return bestBalance
    }

    static func hasWinningExchange(position: Position, player: Player) -> Bool {
        exchangeBalance(position: position, player: player) > 0
    }
}
