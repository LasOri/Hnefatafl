struct ResignAction: Equatable {
    let player: Player
    let confirmRequired: Bool
    let message: String
}

enum ResignButton {
    static func action(for player: Player, confirmed: Bool = false) -> ResignAction {
        let message = confirmed
            ? "\(player == .attacker ? "Attacker" : "Defender") resigns"
            : "Are you sure you want to resign?"
        return ResignAction(player: player, confirmRequired: !confirmed, message: message)
    }
}
