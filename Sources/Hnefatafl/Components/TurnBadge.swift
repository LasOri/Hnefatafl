struct TurnBadge: Equatable {
    let turnNumber: Int
    let player: Player
    let isAITurn: Bool

    var displayText: String {
        let side = player == .attacker ? "Attacker" : "Defender"
        return "Turn \(turnNumber) - \(side)"
    }

    var shortText: String {
        "T\(turnNumber)"
    }
}
