struct PlayerBadge: Equatable {
    let player: Player
    let isActive: Bool
    let captureCount: Int

    var displayName: String {
        switch player {
        case .attacker: return "Attacker"
        case .defender: return "Defender"
        }
    }

    var statusText: String {
        isActive ? "Your turn" : "Waiting"
    }
}
