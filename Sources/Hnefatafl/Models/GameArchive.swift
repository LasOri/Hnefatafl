struct ArchivedGame: Equatable {
    let moves: [Move]
    let result: GameStatus
    let tags: [String]
    let note: String
}

struct GameArchive: Equatable {
    private(set) var games: [ArchivedGame] = []

    var count: Int { games.count }

    mutating func add(_ game: ArchivedGame) {
        games.append(game)
    }

    func filter(tag: String) -> [ArchivedGame] {
        games.filter { $0.tags.contains(tag) }
    }

    func filter(result: GameStatus) -> [ArchivedGame] {
        games.filter { $0.result == result }
    }

    mutating func clear() {
        games.removeAll()
    }
}
