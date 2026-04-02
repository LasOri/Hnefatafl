enum Player {
    case attacker
    case defender

    var opponent: Player {
        switch self {
        case .attacker: return .defender
        case .defender: return .attacker
        }
    }
}
