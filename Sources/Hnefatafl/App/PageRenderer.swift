import LINKER

struct PageRenderer {
    static func render(state: GameState) -> [AnyNode] {
        var children: [AnyNode] = []
        children.append(contentsOf: GameStyleSheet.render())
        children.append(contentsOf: AppComponent.render(state: state))

        let root = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "page-root")
            ],
            children: children
        )
        return [AnyNode(root)]
    }

    static func renderForStore() -> (GameState) -> [AnyNode] {
        { state in render(state: state) }
    }
}
