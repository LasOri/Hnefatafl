struct SoundVariant: Equatable {
    let name: String
    let volume: Double
}

struct MoveSoundVariation {
    static func sound(for type: MoveType) -> String {
        switch type {
        case .regular: return "move"
        case .capture: return "capture"
        case .kingEscape: return "victory"
        case .check: return "alert"
        case .aggressive: return "strike"
        case .defensive: return "shield"
        }
    }

    static func volume(for type: MoveType) -> Double {
        switch type {
        case .regular: return 0.5
        case .capture: return 0.8
        case .kingEscape: return 1.0
        case .check: return 0.9
        case .aggressive: return 0.7
        case .defensive: return 0.6
        }
    }

    static func effect(for type: MoveType) -> SoundVariant {
        SoundVariant(name: sound(for: type), volume: volume(for: type))
    }
}
