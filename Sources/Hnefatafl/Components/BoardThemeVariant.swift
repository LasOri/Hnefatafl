enum BoardThemeVariant: String, CaseIterable, Equatable {
    case wood
    case stone
    case ice
    case dark
    case classic

    var name: String {
        switch self {
        case .wood: return "Wood"
        case .stone: return "Stone"
        case .ice: return "Ice"
        case .dark: return "Dark"
        case .classic: return "Classic"
        }
    }

    var lightSquare: String {
        switch self {
        case .wood: return "#DEB887"
        case .stone: return "#C0C0C0"
        case .ice: return "#E0F0FF"
        case .dark: return "#404040"
        case .classic: return "#F0D9B5"
        }
    }

    var darkSquare: String {
        switch self {
        case .wood: return "#8B4513"
        case .stone: return "#808080"
        case .ice: return "#A0C0E0"
        case .dark: return "#282828"
        case .classic: return "#B58863"
        }
    }

    var next: BoardThemeVariant {
        let all = BoardThemeVariant.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }

    var cssVariables: String {
        "--light-square: \(lightSquare); --dark-square: \(darkSquare);"
    }
}
