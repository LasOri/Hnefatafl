struct StatisticsTracker: Equatable {
    private(set) var gamesPlayed: Int = 0
    private(set) var gamesWon: Int = 0
    private(set) var gamesLost: Int = 0
    private(set) var gamesDraw: Int = 0
    private(set) var totalMoveCount: Int = 0
    private(set) var longestGame: Int = 0
    private(set) var shortestGame: Int = 0
    private(set) var currentWinStreak: Int = 0

    var winRate: Double {
        gamesPlayed > 0 ? Double(gamesWon) / Double(gamesPlayed) : 0.0
    }

    var averageMoveCount: Double {
        gamesPlayed > 0 ? Double(totalMoveCount) / Double(gamesPlayed) : 0.0
    }

    mutating func record(result: GameStatus, playedAs: Player, moveCount: Int) {
        gamesPlayed += 1
        totalMoveCount += moveCount

        if moveCount > longestGame { longestGame = moveCount }
        if shortestGame == 0 || moveCount < shortestGame { shortestGame = moveCount }

        let won: Bool
        switch result {
        case .attackerWins: won = (playedAs == .attacker)
        case .defenderWins: won = (playedAs == .defender)
        case .draw:
            gamesDraw += 1
            currentWinStreak = 0
            return
        case .inProgress:
            return
        }

        if won {
            gamesWon += 1
            currentWinStreak += 1
        } else {
            gamesLost += 1
            currentWinStreak = 0
        }
    }
}
