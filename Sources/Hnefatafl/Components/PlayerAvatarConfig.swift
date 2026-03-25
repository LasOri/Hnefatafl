struct PlayerAvatarConfig: Equatable {
    let player: Player
    let name: String
    let iconName: String

    static func defaultConfig(for player: Player) -> PlayerAvatarConfig {
        switch player {
        case .attacker:
            return PlayerAvatarConfig(
                player: .attacker,
                name: "Attacker",
                iconName: "sword"
            )
        case .defender:
            return PlayerAvatarConfig(
                player: .defender,
                name: "Defender",
                iconName: "shield"
            )
        }
    }
}
