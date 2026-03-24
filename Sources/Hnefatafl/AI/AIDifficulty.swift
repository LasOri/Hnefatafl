enum AIDifficulty: Int, CaseIterable, Equatable {
    case easy = 1
    case medium = 2
    case hard = 3

    var searchDepth: Int { rawValue }

    var label: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }

    var next: AIDifficulty {
        switch self {
        case .easy: return .medium
        case .medium: return .hard
        case .hard: return .easy
        }
    }
}
