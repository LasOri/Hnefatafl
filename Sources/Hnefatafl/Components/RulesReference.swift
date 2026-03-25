struct RuleEntry: Equatable {
    let title: String
    let description: String
}

enum RulesReference {
    static let rules: [RuleEntry] = [
        RuleEntry(title: "Movement", description: "All pieces move like rooks in chess"),
        RuleEntry(title: "Capture", description: "Pieces are captured by custodial sandwich"),
        RuleEntry(title: "King Escape", description: "King wins by reaching a corner"),
        RuleEntry(title: "King Capture", description: "King is captured when surrounded on all four sides"),
        RuleEntry(title: "Throne", description: "Only the king may occupy the throne"),
    ]

    static var count: Int { rules.count }
}
