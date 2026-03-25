struct MatchSetup: Equatable {
    let playerSide: Player
    let aiEnabled: Bool
    let timeLimit: Double?
    let variant: String

    var hasTimeLimit: Bool { timeLimit != nil }
}
