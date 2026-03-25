struct MatchRecord: Equatable {
    let winner: Player?
    let moveCount: Int
    let timestamp: Double
}

struct MatchHistory: Equatable {
    private(set) var records: [MatchRecord] = []

    var totalGames: Int { records.count }
    var attackerWins: Int { records.filter { $0.winner == .attacker }.count }
    var defenderWins: Int { records.filter { $0.winner == .defender }.count }
    var draws: Int { records.filter { $0.winner == nil }.count }

    mutating func record(winner: Player?, moveCount: Int, at timestamp: Double = 0) {
        records.append(MatchRecord(winner: winner, moveCount: moveCount, timestamp: timestamp))
    }

    var averageMoveCount: Double {
        guard !records.isEmpty else { return 0 }
        return Double(records.map(\.moveCount).reduce(0, +)) / Double(records.count)
    }
}
