import LINKER

struct RulesContent {
    static func render() -> [AnyNode] {
        let sections: [(String, String)] = [
            ("Objective", "Defenders must help the King escape to any corner. Attackers must capture the King before he can escape."),
            ("Movement", "All pieces move like a rook in chess: any number of squares horizontally or vertically. No jumping over other pieces."),
            ("Capture", "A piece is captured when two enemy pieces sandwich it on opposite sides horizontally or vertically. The King requires four enemies (or walls) to be captured."),
            ("Special Squares", "Only the King may land on the throne (center) or corners. Other pieces may pass through the throne but not stop on it."),
            ("Winning", "Defenders win when the King reaches any corner square. Attackers win when the King is surrounded on all four sides.")
        ]

        var children: [AnyNode] = []

        let title = Element<AnyHTMLContext>(
            tag: "h2",
            attributes: [Attribute(name: "class", value: "rules-title")],
            children: [AnyNode(Text("Hnefatafl Rules"))]
        )
        children.append(AnyNode(title))

        for (heading, body) in sections {
            let h = Element<AnyHTMLContext>(
                tag: "h3",
                attributes: [],
                children: [AnyNode(Text(heading))]
            )
            let p = Element<AnyHTMLContext>(
                tag: "p",
                attributes: [],
                children: [AnyNode(Text(body))]
            )
            children.append(AnyNode(h))
            children.append(AnyNode(p))
        }

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "rules-content")],
            children: children
        )
        return [AnyNode(container)]
    }
}
