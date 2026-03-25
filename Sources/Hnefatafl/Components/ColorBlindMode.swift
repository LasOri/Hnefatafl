struct ColorPalette: Equatable {
    let attacker: String
    let defender: String
    let king: String
}

enum ColorBlindMode: String, CaseIterable, Equatable {
    case normal
    case protanopia
    case deuteranopia
    case tritanopia

    var name: String {
        switch self {
        case .normal: return "Normal"
        case .protanopia: return "Protanopia"
        case .deuteranopia: return "Deuteranopia"
        case .tritanopia: return "Tritanopia"
        }
    }

    var palette: ColorPalette {
        switch self {
        case .normal:
            return ColorPalette(attacker: "#D32F2F", defender: "#1976D2", king: "#FFC107")
        case .protanopia:
            return ColorPalette(attacker: "#E69F00", defender: "#0072B2", king: "#F0E442")
        case .deuteranopia:
            return ColorPalette(attacker: "#D55E00", defender: "#56B4E9", king: "#F0E442")
        case .tritanopia:
            return ColorPalette(attacker: "#CC79A7", defender: "#009E73", king: "#F0E442")
        }
    }

    var next: ColorBlindMode {
        let all = ColorBlindMode.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }
}
