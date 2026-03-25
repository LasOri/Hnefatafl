struct HistoryEntry: Equatable {
    let player: Player
    let notation: String
    let moveNumber: Int
}

struct GameHistoryLog: Equatable {
    let entries: [HistoryEntry]

    init(entries: [HistoryEntry] = []) {
        self.entries = entries
    }

    func record(entry: HistoryEntry) -> GameHistoryLog {
        GameHistoryLog(entries: entries + [entry])
    }

    func clear() -> GameHistoryLog {
        GameHistoryLog(entries: [])
    }

    static func from(game: Game) -> GameHistoryLog {
        var log = GameHistoryLog()
        for (i, move) in game.moveHistory.enumerated() {
            let player: Player = i % 2 == 0 ? .attacker : .defender
            let notation = NotationExporter.algebraic(move)
            let moveNumber = i / 2 + 1
            log = log.record(entry: HistoryEntry(player: player, notation: notation, moveNumber: moveNumber))
        }
        return log
    }
}
