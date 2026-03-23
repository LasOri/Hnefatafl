import LINKER

struct GameOverOverlay {
    static func render(status: GameStatus) -> [AnyNode] {
        switch status {
        case .inProgress:
            return []
        case .attackerWins:
            return overlayNodes(text: "Attackers Win")
        case .defenderWins:
            return overlayNodes(text: "Defenders Win")
        case .draw:
            return overlayNodes(text: "Draw")
        }
    }

    private static func overlayNodes(text: String) -> [AnyNode] {
        let heading = Element<AnyHTMLContext>(
            tag: "h2",
            attributes: [
                Attribute(name: "class", value: "game-over-text")
            ],
            children: [AnyNode(Text(text))]
        )
        let overlay = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "game-over-overlay"),
                Attribute(name: "role", value: "alert"),
                Attribute(name: "aria-live", value: "assertive")
            ],
            children: [AnyNode(heading)]
        )
        return [AnyNode(overlay)]
    }
}
