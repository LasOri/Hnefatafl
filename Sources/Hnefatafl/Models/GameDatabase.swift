struct GameDatabaseEntry: Equatable {
    let pgn: HnefataflPGN
    let result: GameStatus
    let moveCount: Int
    let timestamp: Double
}

struct DatabaseStats: Equatable {
    let attackerWins: Int
    let defenderWins: Int
    let draws: Int
    let totalGames: Int
    let averageMoveCount: Double
}

struct GameDatabase: Equatable {
    private(set) var entries: [GameDatabaseEntry] = []

    var count: Int { entries.count }

    var latest: GameDatabaseEntry? { entries.first }

    var stats: DatabaseStats {
        let aw = entries.filter { $0.result == .attackerWins }.count
        let dw = entries.filter { $0.result == .defenderWins }.count
        let dr = entries.filter { $0.result == .draw }.count
        let total = entries.count
        let avg = total > 0 ? Double(entries.reduce(0) { $0 + $1.moveCount }) / Double(total) : 0.0
        return DatabaseStats(attackerWins: aw, defenderWins: dw, draws: dr, totalGames: total, averageMoveCount: avg)
    }

    mutating func add(_ entry: GameDatabaseEntry) {
        entries.append(entry)
        entries.sort { $0.timestamp > $1.timestamp }
    }

    func filter(result: GameStatus) -> [GameDatabaseEntry] {
        entries.filter { $0.result == result }
    }
}
