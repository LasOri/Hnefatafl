struct GameStatistics: Equatable {
    let attackerWins: Int
    let defenderWins: Int
    let draws: Int
    let totalMoveCount: Int
    let longestGame: Int
    let shortestGame: Int

    var totalGames: Int { attackerWins + defenderWins + draws }

    var averageMoveCount: Int {
        guard totalGames > 0 else { return 0 }
        return totalMoveCount / totalGames
    }

    init() {
        attackerWins = 0
        defenderWins = 0
        draws = 0
        totalMoveCount = 0
        longestGame = 0
        shortestGame = 0
    }

    init(attackerWins: Int, defenderWins: Int, draws: Int, totalMoveCount: Int, longestGame: Int, shortestGame: Int) {
        self.attackerWins = attackerWins
        self.defenderWins = defenderWins
        self.draws = draws
        self.totalMoveCount = totalMoveCount
        self.longestGame = longestGame
        self.shortestGame = shortestGame
    }

    func record(result: GameStatus, moveCount: Int) -> GameStatistics {
        let newAttacker = result == .attackerWins ? attackerWins + 1 : attackerWins
        let newDefender = result == .defenderWins ? defenderWins + 1 : defenderWins
        let newDraws = result == .draw ? draws + 1 : draws
        let newTotal = totalMoveCount + moveCount
        let newLongest = max(longestGame, moveCount)
        let newShortest = totalGames == 0 ? moveCount : min(shortestGame, moveCount)
        return GameStatistics(
            attackerWins: newAttacker,
            defenderWins: newDefender,
            draws: newDraws,
            totalMoveCount: newTotal,
            longestGame: newLongest,
            shortestGame: newShortest
        )
    }
}
