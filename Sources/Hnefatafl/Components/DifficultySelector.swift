enum DifficultyLevel: String, CaseIterable, Equatable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case expert = "Expert"

    var searchDepth: Int {
        switch self {
        case .beginner: return 1
        case .intermediate: return 2
        case .advanced: return 3
        case .expert: return 4
        }
    }
}

enum DifficultySelector {
    static func next(after current: DifficultyLevel) -> DifficultyLevel {
        let all = DifficultyLevel.allCases
        guard let idx = all.firstIndex(of: current) else { return .beginner }
        return all[(idx + 1) % all.count]
    }
}
