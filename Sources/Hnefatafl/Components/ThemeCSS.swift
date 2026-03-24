struct ThemeCSS {
    static func generate(theme: BoardTheme) -> String {
        let vars = themeVariables(theme: theme)
        return ":root { \(vars) }"
    }

    private static func themeVariables(theme: BoardTheme) -> String {
        switch theme {
        case .classic:
            return "--light-square: #d4a76a; --dark-square: #b8864e; --accent-color: #c9a84c; --highlight-color: #ffd700; --board-color: #5c3a1e; --piece-color: #2d1b0e;"
        case .darkWood:
            return "--light-square: #6b4226; --dark-square: #4a2f15; --accent-color: #b8860b; --highlight-color: #daa520; --board-color: #1a0f05; --piece-color: #1a0a00;"
        case .marble:
            return "--light-square: #f0ece4; --dark-square: #d8d0c8; --accent-color: #8b7355; --highlight-color: #bfa86a; --board-color: #c0c0c0; --piece-color: #333;"
        case .ice:
            return "--light-square: #b8d4e8; --dark-square: #8bc0d8; --accent-color: #5090b0; --highlight-color: #7ec8e3; --board-color: #1a2a3a; --piece-color: #0a1520;"
        }
    }
}
