struct PlayerProfile: Equatable {
    let name: String
    var rating: Int
    private(set) var wins: Int
    private(set) var losses: Int
    private(set) var draws: Int

    init(name: String, rating: Int = 1200) {
        self.name = name
        self.rating = rating
        self.wins = 0
        self.losses = 0
        self.draws = 0
    }

    var totalGames: Int { wins + losses + draws }

    var winRate: Double {
        guard totalGames > 0 else { return 0 }
        return Double(wins) / Double(totalGames)
    }

    mutating func recordWin() { wins += 1 }
    mutating func recordLoss() { losses += 1 }
    mutating func recordDraw() { draws += 1 }
}
