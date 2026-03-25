struct MatchResult: Equatable {
    let winner: Player?
    let moveCount: Int
    let duration: Double
}

struct MatchResultTracker {
    private(set) var results: [MatchResult] = []

    mutating func record(_ result: MatchResult) {
        results.append(result)
    }

    var attackerWins: Int {
        results.filter { $0.winner == .attacker }.count
    }

    var defenderWins: Int {
        results.filter { $0.winner == .defender }.count
    }

    var drawCount: Int {
        results.filter { $0.winner == nil }.count
    }

    var averageMoveCount: Int {
        guard !results.isEmpty else { return 0 }
        return results.map(\.moveCount).reduce(0, +) / results.count
    }
}
