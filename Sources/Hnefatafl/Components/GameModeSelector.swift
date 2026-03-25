enum GameModeOption: String, CaseIterable, Equatable {
    case humanVsHuman = "Human vs Human"
    case humanVsAI = "Human vs AI"
    case aiVsAI = "AI vs AI"

    var label: String { rawValue }
    var requiresAI: Bool { self != .humanVsHuman }
    var isAutoPlay: Bool { self == .aiVsAI }
}

enum GameModeSelector {
    static var allModes: [GameModeOption] { GameModeOption.allCases }

    static func next(after mode: GameModeOption) -> GameModeOption {
        let all = GameModeOption.allCases
        guard let idx = all.firstIndex(of: mode) else { return .humanVsHuman }
        return all[(idx + 1) % all.count]
    }
}
