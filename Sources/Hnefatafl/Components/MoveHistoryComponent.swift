import LINKER

struct MoveHistoryComponent {
    static func render(state: GameState) -> [AnyNode] {
        let items: [AnyNode] = state.game.moveHistory.enumerated().map { index, move in
            let moveNumber = index / 2 + 1
            let isAttacker = index % 2 == 0
            let prefix = isAttacker ? "\(moveNumber). " : ""
            let fromCol = String(UnicodeScalar(65 + move.fromCol)!)
            let toCol = String(UnicodeScalar(65 + move.toCol)!)
            let text = "\(prefix)\(fromCol)\(move.fromRow + 1)-\(toCol)\(move.toRow + 1)"

            let li = Element<AnyHTMLContext>(
                tag: "li",
                attributes: [Attribute(name: "class", value: "move-item")],
                children: [AnyNode(Text(text))]
            )
            return AnyNode(li)
        }

        let list = Element<AnyHTMLContext>(
            tag: "ol",
            attributes: [
                Attribute(name: "class", value: "move-history"),
                Attribute(name: "aria-label", value: "Move history")
            ],
            children: items
        )

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "move-history-panel")],
            children: [AnyNode(list)]
        )
        return [AnyNode(container)]
    }
}
