enum ThemeChoice: String, CaseIterable, Equatable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"

    var label: String { rawValue }
}

enum ThemePreference {
    static func next(after current: ThemeChoice) -> ThemeChoice {
        let all = ThemeChoice.allCases
        guard let idx = all.firstIndex(of: current) else { return .light }
        return all[(idx + 1) % all.count]
    }

    static func cssClass(for theme: ThemeChoice) -> String {
        "theme-\(theme.rawValue.lowercased())"
    }
}
