struct HelpTopic: Equatable {
    let title: String
    let content: String
}

enum HelpOverlay {
    static let topics: [HelpTopic] = [
        HelpTopic(title: "How to Move", content: "Tap a piece, then tap a highlighted square"),
        HelpTopic(title: "Capturing", content: "Sandwich enemy pieces between two of your own"),
        HelpTopic(title: "King Escape", content: "Move the king to any corner to win as defender"),
        HelpTopic(title: "Attacker Goal", content: "Surround the king on all four sides"),
    ]

    static var count: Int { topics.count }
}
