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
        let playAgainBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-play-again"),
                Attribute(name: "data-action", value: "new-game"),
                Attribute(name: "aria-label", value: "Play again"),
                Attribute(name: "autofocus", value: "true")
            ],
            children: [AnyNode(Text("Play Again"))]
        )
        let overlay = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "game-over-overlay"),
                Attribute(name: "role", value: "alertdialog"),
                Attribute(name: "aria-live", value: "assertive"),
                Attribute(name: "aria-label", value: text)
            ],
            children: [AnyNode(heading), AnyNode(playAgainBtn)]
        )
        return [AnyNode(overlay)]
    }
}
