enum PlayerLabel {
    static func name(for player: Player) -> String {
        switch player {
        case .attacker: return "Attacker"
        case .defender: return "Defender"
        }
    }

    static func icon(for player: Player) -> String {
        switch player {
        case .attacker: return "sword"
        case .defender: return "shield"
        }
    }

    static func color(for player: Player) -> String {
        switch player {
        case .attacker: return "#c0392b"
        case .defender: return "#2980b9"
        }
    }
}
