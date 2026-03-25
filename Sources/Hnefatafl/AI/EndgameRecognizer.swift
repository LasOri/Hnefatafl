enum EndgamePattern: String, Equatable {
    case kingAlone = "King Alone"
    case kingWithDefender = "King + Defender"
    case fewAttackers = "Few Attackers"
    case unknown = "Unknown"
}

enum EndgameRecognizer {
    static func recognize(position: Position) -> EndgamePattern {
        let defCount = position.defenderCount
        let atkCount = position.attackerCount
        if defCount == 1 && atkCount == 0 { return .kingAlone }
        if defCount == 2 && atkCount <= 2 { return .kingWithDefender }
        if atkCount <= 3 && defCount > 2 { return .fewAttackers }
        return .unknown
    }
}
