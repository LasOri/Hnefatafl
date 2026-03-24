import LINKER

struct NotationPanel {
    static func render(moves: [Move], currentStep: Int?) -> [AnyNode] {
        var children: [AnyNode] = []

        for (index, move) in moves.enumerated() {
            if index % 2 == 0 {
                let moveNum = (index / 2) + 1
                let numSpan = Element<AnyHTMLContext>(
                    tag: "span",
                    attributes: [Attribute(name: "class", value: "notation-number")],
                    children: [AnyNode(Text("\(moveNum)."))]
                )
                children.append(AnyNode(numSpan))
            }

            let notation = NotationExporter.algebraic(move)
            var classes = "notation-move"
            if let step = currentStep, step == index {
                classes += " notation-active"
            }

            let moveSpan = Element<AnyHTMLContext>(
                tag: "span",
                attributes: [
                    Attribute(name: "class", value: classes),
                    Attribute(name: "data-step", value: "\(index)")
                ],
                children: [AnyNode(Text(notation))]
            )
            children.append(AnyNode(moveSpan))
        }

        let panel = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "notation-panel")],
            children: children
        )

        return [AnyNode(panel)]
    }
}
