import LINKER

struct StatusComponent {
    static func render(state: GameState) -> [AnyNode] {
        let status = state.game.status
        let turnText: String
        let statusClass: String

        switch status {
        case .inProgress:
            let player = state.game.currentPlayer == .attacker ? "Attacker" : "Defender"
            let isAI = isCurrentPlayerAI(state: state)
            turnText = isAI ? "\(player)'s turn (AI)" : "\(player)'s turn"
            statusClass = "status-in-progress"
        case .defenderWins:
            turnText = "Defenders win!"
            statusClass = "status-game-over"
        case .attackerWins:
            turnText = "Attackers win!"
            statusClass = "status-game-over"
        case .draw:
            turnText = "Draw!"
            statusClass = "status-game-over"
        }

        let turnElement = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "status-turn \(statusClass)"),
                Attribute(name: "aria-live", value: "polite")
            ],
            children: [AnyNode(Text(turnText))]
        )

        let captureElement = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "status-captures")],
            children: [
                AnyNode(captureCount(label: "Attackers captured", count: state.attackersCaptured)),
                AnyNode(captureCount(label: "Defenders captured", count: state.defendersCaptured))
            ]
        )

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "status-bar")],
            children: [AnyNode(turnElement), AnyNode(captureElement)]
        )
        return [AnyNode(container)]
    }

    private static func isCurrentPlayerAI(state: GameState) -> Bool {
        guard case .humanVsAI(let humanSide) = state.aiMode else { return false }
        return state.game.currentPlayer != humanSide
    }

    private static func captureCount(label: String, count: Int) -> Element<AnyHTMLContext> {
        Element<AnyHTMLContext>(
            tag: "span",
            attributes: [
                Attribute(name: "class", value: "capture-count"),
                Attribute(name: "aria-label", value: "\(label): \(count)")
            ],
            children: [AnyNode(Text("\(count)"))]
        )
    }
}
