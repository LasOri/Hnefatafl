struct GameLogEntry: Equatable {
    let moveNumber: Int
    let player: Player
    let description: String
}

struct GameLog: Equatable {
    private(set) var entries: [GameLogEntry] = []

    mutating func addEntry(moveNumber: Int, player: Player, description: String) {
        entries.append(GameLogEntry(moveNumber: moveNumber, player: player, description: description))
    }

    var count: Int { entries.count }
    var lastEntry: GameLogEntry? { entries.last }

    mutating func clear() { entries.removeAll() }
}
