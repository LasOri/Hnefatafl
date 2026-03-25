struct GameSession: Equatable {
    let id: String
    let startTime: Double
    let players: (String, String)
    private var endTime: Double?

    init(id: String, startTime: Double, players: (String, String)) {
        self.id = id
        self.startTime = startTime
        self.players = players
        self.endTime = nil
    }

    var isActive: Bool {
        endTime == nil
    }

    func elapsed(currentTime: Double) -> Double {
        let end = endTime ?? currentTime
        return end - startTime
    }

    mutating func end(at time: Double? = nil) {
        if endTime == nil {
            endTime = time ?? startTime
        }
    }

    static func == (lhs: GameSession, rhs: GameSession) -> Bool {
        lhs.id == rhs.id &&
        lhs.startTime == rhs.startTime &&
        lhs.players.0 == rhs.players.0 &&
        lhs.players.1 == rhs.players.1 &&
        lhs.endTime == rhs.endTime
    }
}
