enum PieceStyle: String, CaseIterable, Equatable {
    case classic
    case modern
    case minimal
    case runic

    var name: String {
        switch self {
        case .classic: return "Classic"
        case .modern: return "Modern"
        case .minimal: return "Minimal"
        case .runic: return "Runic"
        }
    }

    var cssClass: String {
        "piece-style-\(rawValue)"
    }

    var attackerSymbol: String {
        switch self {
        case .classic: return "⚔"
        case .modern: return "●"
        case .minimal: return "▲"
        case .runic: return "ᚦ"
        }
    }

    var defenderSymbol: String {
        switch self {
        case .classic: return "🛡"
        case .modern: return "○"
        case .minimal: return "△"
        case .runic: return "ᚱ"
        }
    }

    var kingSymbol: String {
        switch self {
        case .classic: return "♔"
        case .modern: return "◉"
        case .minimal: return "★"
        case .runic: return "ᚲ"
        }
    }

    var next: PieceStyle {
        let all = PieceStyle.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }
}
