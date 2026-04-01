enum SelectedVariant: String, CaseIterable, Equatable {
    case copenhagen
    case tablut

    var label: String {
        switch self {
        case .copenhagen: return "Copenhagen"
        case .tablut: return "Tablut"
        }
    }

    var startPosition: Position {
        switch self {
        case .copenhagen: return .copenhagenStart()
        case .tablut: return .tablutStart()
        }
    }

    var next: SelectedVariant {
        let all = SelectedVariant.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }
}
