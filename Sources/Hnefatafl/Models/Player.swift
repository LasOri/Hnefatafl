enum Player {
    case attacker
    case defender

    var opponent: Player {
        switch self {
        case .attacker: return .defender
        case .defender: return .attacker
        }
    }

    var roleString: String {
        switch self {
        case .attacker: return "attacker"
        case .defender: return "defender"
        }
    }

    static func fromRole(_ role: String) -> Player? {
        switch role {
        case "attacker": return .attacker
        case "defender": return .defender
        default: return nil
        }
    }
}
