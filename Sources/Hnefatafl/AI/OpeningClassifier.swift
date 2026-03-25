enum OpeningType: String, Equatable {
    case standard = "Standard"
    case aggressive = "Aggressive"
    case defensive = "Defensive"
    case unknown = "Unknown"
}

enum OpeningClassifier {
    static func classify(moves: [Move]) -> OpeningType {
        guard !moves.isEmpty else { return .standard }
        if moves.count < 4 { return .unknown }
        let firstMove = moves[0]
        let centerDist = abs(firstMove.toRow - 5) + abs(firstMove.toCol - 5)
        if centerDist <= 3 { return .aggressive }
        if centerDist >= 7 { return .defensive }
        return .standard
    }
}
