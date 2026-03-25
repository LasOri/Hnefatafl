enum Orientation: String, CaseIterable, Equatable {
    case attackerBottom = "Attacker Bottom"
    case defenderBottom = "Defender Bottom"
    case auto = "Auto"
}

enum BoardOrientation {
    static func effectiveOrientation(selected: Orientation, currentPlayer: Player) -> Orientation {
        switch selected {
        case .attackerBottom, .defenderBottom: return selected
        case .auto: return currentPlayer == .attacker ? .attackerBottom : .defenderBottom
        }
    }

    static func shouldFlip(orientation: Orientation) -> Bool {
        orientation == .defenderBottom
    }

    static func next(after current: Orientation) -> Orientation {
        let all = Orientation.allCases
        guard let idx = all.firstIndex(of: current) else { return .attackerBottom }
        return all[(idx + 1) % all.count]
    }
}
