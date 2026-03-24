import LINKER

struct AppComponent {
    static func render(state: GameState) -> [AnyNode] {
        var children: [AnyNode] = []

        children.append(contentsOf: StatusComponent.render(state: state))
        children.append(contentsOf: BoardComponent.render(state: state))
        children.append(contentsOf: toolbarNodes(state: state))
        children.append(contentsOf: MoveHistoryComponent.render(state: state))
        children.append(contentsOf: GameOverOverlay.render(status: state.game.status))

        if state.showRules {
            let closeBtn = Element<AnyHTMLContext>(
                tag: "button",
                attributes: [
                    Attribute(name: "class", value: "btn btn-close-rules"),
                    Attribute(name: "data-action", value: "toggle-rules"),
                    Attribute(name: "aria-label", value: "Close rules")
                ],
                children: [AnyNode(Text("Close"))]
            )
            var overlayChildren = RulesContent.render()
            overlayChildren.append(AnyNode(closeBtn))
            let overlay = Element<AnyHTMLContext>(
                tag: "div",
                attributes: [
                    Attribute(name: "class", value: "rules-overlay"),
                    Attribute(name: "role", value: "dialog"),
                    Attribute(name: "aria-label", value: "Game rules")
                ],
                children: overlayChildren
            )
            children.append(AnyNode(overlay))
        }

        let announcementText = state.announcement ?? ""
        let liveRegion = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "aria-live", value: "assertive"),
                Attribute(name: "class", value: "sr-only"),
                Attribute(name: "style", value: "position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0,0,0,0)")
            ],
            children: [AnyNode(Text(announcementText))]
        )
        children.append(AnyNode(liveRegion))

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

        let difficultyLabel = "AI: \(state.aiDifficulty.label)"
        let difficultyBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-difficulty"),
                Attribute(name: "data-action", value: "cycle-difficulty"),
                Attribute(name: "aria-label", value: difficultyLabel)
            ],
            children: [AnyNode(Text(difficultyLabel))]
        )

        let flipLabel = state.boardFlipped ? "Unflip Board" : "Flip Board"
        let flipBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-flip"),
                Attribute(name: "data-action", value: "flip-board"),
                Attribute(name: "aria-label", value: flipLabel)
            ],
            children: [AnyNode(Text(flipLabel))]
        )

        let rulesBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-rules"),
                Attribute(name: "data-action", value: "toggle-rules"),
                Attribute(name: "aria-label", value: "Rules")
            ],
            children: [AnyNode(Text("Rules"))]
        )

        let toolbar = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "toolbar"),
                Attribute(name: "role", value: "toolbar"),
                Attribute(name: "aria-label", value: "Game controls")
            ],
            children: [AnyNode(undoBtn), AnyNode(newGameBtn), AnyNode(aiBtn), AnyNode(muteBtn), AnyNode(difficultyBtn), AnyNode(flipBtn), AnyNode(rulesBtn)]
        )
        return [AnyNode(toolbar)]
    }
}
