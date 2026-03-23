import LINKER

struct AppComponent {
    static func render(state: GameState) -> [AnyNode] {
        var children: [AnyNode] = []

        children.append(contentsOf: StatusComponent.render(state: state))
        children.append(contentsOf: BoardComponent.render(state: state))
        children.append(contentsOf: toolbarNodes(state: state))
        children.append(contentsOf: MoveHistoryComponent.render(state: state))
        children.append(contentsOf: GameOverOverlay.render(status: state.game.status))

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "viking-app")
            ],
            children: children
        )
        return [AnyNode(container)]
    }

    private static func toolbarNodes(state: GameState) -> [AnyNode] {
        let aiMode = state.aiMode
        let undoBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-undo"),
                Attribute(name: "data-action", value: "undo"),
                Attribute(name: "aria-label", value: "Undo last move")
            ],
            children: [AnyNode(Text("Undo"))]
        )

        let newGameBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-new-game"),
                Attribute(name: "data-action", value: "new-game"),
                Attribute(name: "aria-label", value: "Start new game")
            ],
            children: [AnyNode(Text("New Game"))]
        )

        let aiLabel = aiMode == .humanVsHuman ? "Play vs AI" : "Play vs Human"
        let aiBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-ai"),
                Attribute(name: "data-action", value: "toggle-ai"),
                Attribute(name: "aria-label", value: aiLabel)
            ],
            children: [AnyNode(Text(aiLabel))]
        )

        let muteLabel = state.muted ? "Unmute" : "Mute"
        let muteBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-mute"),
                Attribute(name: "data-action", value: "toggle-mute"),
                Attribute(name: "aria-label", value: muteLabel)
            ],
            children: [AnyNode(Text(muteLabel))]
        )

        let toolbar = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "toolbar"),
                Attribute(name: "role", value: "toolbar"),
                Attribute(name: "aria-label", value: "Game controls")
            ],
            children: [AnyNode(undoBtn), AnyNode(newGameBtn), AnyNode(aiBtn), AnyNode(muteBtn)]
        )
        return [AnyNode(toolbar)]
    }
}
