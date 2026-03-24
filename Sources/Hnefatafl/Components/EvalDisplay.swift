import LINKER

struct EvalDisplay {
    static func render(normalizedValue: Double) -> [AnyNode] {
        let pct = EvalBar.percentage(normalizedValue: normalizedValue)
        let lbl = EvalBar.label(normalizedValue: normalizedValue)

        let fill = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "eval-fill"),
                Attribute(name: "style", value: "width: \(pct)%")
            ],
            children: []
        )

        let bar = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "eval-bar"),
                Attribute(name: "role", value: "meter"),
                Attribute(name: "aria-label", value: lbl),
                Attribute(name: "aria-valuenow", value: "\(pct)"),
                Attribute(name: "aria-valuemin", value: "0"),
                Attribute(name: "aria-valuemax", value: "100")
            ],
            children: [AnyNode(fill)]
        )

        return [AnyNode(bar)]
    }
}
