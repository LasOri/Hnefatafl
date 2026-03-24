enum BoardTheme: String, CaseIterable, Equatable {
    case classic
    case darkWood
    case marble
    case ice

    var label: String {
        switch self {
        case .classic: return "Classic"
        case .darkWood: return "Dark Wood"
        case .marble: return "Marble"
        case .ice: return "Ice"
        }
    }

    var next: BoardTheme {
        let all = BoardTheme.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }

    var cssVariables: String {
        switch self {
        case .classic:
            return """
            --board-bg: #5c3a1e; --square-bg: #d4a76a; --square-corner: #8b6914; \
            --square-throne: #c9a84c; --text-primary: #2d1b0e; --text-light: #e8dcc8; \
            --accent-gold: #c9a84c;
            """
        case .darkWood:
            return """
            --board-bg: #1a0f05; --square-bg: #6b4226; --square-corner: #4a2f15; \
            --square-throne: #8b5e3c; --text-primary: #1a0a00; --text-light: #d4c4a8; \
            --accent-gold: #b8860b;
            """
        case .marble:
            return """
            --board-bg: #c0c0c0; --square-bg: #f0ece4; --square-corner: #a8a0a0; \
            --square-throne: #d8d0c8; --text-primary: #333; --text-light: #555; \
            --accent-gold: #8b7355;
            """
        case .ice:
            return """
            --board-bg: #1a2a3a; --square-bg: #b8d4e8; --square-corner: #6a9ab8; \
            --square-throne: #8bc0d8; --text-primary: #0a1520; --text-light: #d0e8f0; \
            --accent-gold: #5090b0;
            """
        }
    }
}
