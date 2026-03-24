import LINKER

struct ErrorBoundary {
    static func render(children: [AnyNode]) -> [AnyNode] {
        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "error-boundary")],
            children: children
        )
        return [AnyNode(container)]
    }
}
