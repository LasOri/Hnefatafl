struct PieceCountWidget: Equatable {
    let attackers: Int
    let defenders: Int
    let kingPresent: Bool
    let showDiff: Bool

    var differenceText: String {
        guard showDiff else { return "" }
        let diff = attackers - defenders
        if diff > 0 {
            return "+\(diff) attacker"
        } else if diff < 0 {
            return "+\(-diff) defender"
        }
        return "Even"
    }
}
