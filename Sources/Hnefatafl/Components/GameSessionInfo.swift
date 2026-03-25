struct GameSessionInfo: Equatable {
    let sessionId: Int
    let startDate: String
    let movesMade: Int
    let isComplete: Bool

    var statusText: String {
        if isComplete {
            return "Completed (\(movesMade) moves)"
        }
        return "In progress (\(movesMade) moves)"
    }
}
