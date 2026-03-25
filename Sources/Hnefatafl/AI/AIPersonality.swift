enum AIPersonality: String, CaseIterable, Equatable {
    case aggressive
    case defensive
    case balanced

    var name: String {
        switch self {
        case .aggressive: return "Aggressive"
        case .defensive: return "Defensive"
        case .balanced: return "Balanced"
        }
    }

    var description: String {
        switch self {
        case .aggressive: return "Prioritizes capturing enemy pieces"
        case .defensive: return "Prioritizes king safety and defense"
        case .balanced: return "Balanced approach to all factors"
        }
    }

    var weights: EvalWeights {
        switch self {
        case .aggressive: return .aggressive
        case .defensive: return .defensive
        case .balanced: return EvalWeights()
        }
    }

    var next: AIPersonality {
        let all = AIPersonality.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }
}
