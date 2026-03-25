struct TurnRecord: Equatable {
    let move: Move
    let player: Player
    let captureCount: Int
    let timeSpent: Double
    let evaluation: Int
}

struct TurnHistory: Equatable {
    private(set) var turns: [TurnRecord] = []

    var turnCount: Int { turns.count }

    var totalCaptures: Int {
        turns.reduce(0) { $0 + $1.captureCount }
    }

    var totalTimeSpent: Double {
        turns.reduce(0.0) { $0 + $1.timeSpent }
    }

    var lastTurn: TurnRecord? {
        turns.last
    }

    func turns(for player: Player) -> [TurnRecord] {
        turns.filter { $0.player == player }
    }

    mutating func addTurn(_ record: TurnRecord) {
        turns.append(record)
    }
}
