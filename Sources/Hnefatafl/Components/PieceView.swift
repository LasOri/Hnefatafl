import LINKER

struct PieceView {
    static func render(piece: Piece) -> [AnyNode] {
        switch piece {
        case .attacker: return attackerSVG()
        case .defender: return defenderSVG()
        case .king: return kingSVG()
        }
    }

    private static func attackerSVG() -> [AnyNode] {
        let circle = Element<AnyHTMLContext>(
            tag: "circle",
            attributes: [
                Attribute(name: "cx", value: "20"),
                Attribute(name: "cy", value: "20"),
                Attribute(name: "r", value: "16"),
                Attribute(name: "fill", value: "#2d1b0e"),
                Attribute(name: "stroke", value: "#1a0f08"),
                Attribute(name: "stroke-width", value: "2")
            ],
            children: []
        )
        let axePath = Element<AnyHTMLContext>(
            tag: "path",
            attributes: [
                Attribute(name: "d", value: "M14 12 L20 8 L26 12 L24 20 L16 20 Z"),
                Attribute(name: "fill", value: "#8b6914"),
                Attribute(name: "stroke", value: "#6b4f10"),
                Attribute(name: "stroke-width", value: "1")
            ],
            children: []
        )
        return [AnyNode(svgContainer(className: "piece-svg-attacker", children: [AnyNode(circle), AnyNode(axePath)]))]
    }

    private static func defenderSVG() -> [AnyNode] {
        let circle = Element<AnyHTMLContext>(
            tag: "circle",
            attributes: [
                Attribute(name: "cx", value: "20"),
                Attribute(name: "cy", value: "20"),
                Attribute(name: "r", value: "16"),
                Attribute(name: "fill", value: "#e8dcc8"),
                Attribute(name: "stroke", value: "#b8a890"),
                Attribute(name: "stroke-width", value: "2")
            ],
            children: []
        )
        let shieldPath = Element<AnyHTMLContext>(
            tag: "path",
            attributes: [
                Attribute(name: "d", value: "M14 14 L20 10 L26 14 L26 24 L20 28 L14 24 Z"),
                Attribute(name: "fill", value: "#4a7c59"),
                Attribute(name: "stroke", value: "#2d5a3a"),
                Attribute(name: "stroke-width", value: "1")
            ],
            children: []
        )
        return [AnyNode(svgContainer(className: "piece-svg-defender", children: [AnyNode(circle), AnyNode(shieldPath)]))]
    }

    private static func kingSVG() -> [AnyNode] {
        let circle = Element<AnyHTMLContext>(
            tag: "circle",
            attributes: [
                Attribute(name: "cx", value: "20"),
                Attribute(name: "cy", value: "20"),
                Attribute(name: "r", value: "16"),
                Attribute(name: "fill", value: "#e8dcc8"),
                Attribute(name: "stroke", value: "#c9a84c"),
                Attribute(name: "stroke-width", value: "2")
            ],
            children: []
        )
        let crownPath = Element<AnyHTMLContext>(
            tag: "path",
            attributes: [
                Attribute(name: "d", value: "M12 18 L16 10 L20 14 L24 10 L28 18 Z"),
                Attribute(name: "fill", value: "#c9a84c"),
                Attribute(name: "stroke", value: "#a08030"),
                Attribute(name: "stroke-width", value: "1")
            ],
            children: []
        )
        let shieldPath = Element<AnyHTMLContext>(
            tag: "path",
            attributes: [
                Attribute(name: "d", value: "M15 20 L20 18 L25 20 L25 27 L20 30 L15 27 Z"),
                Attribute(name: "fill", value: "#4a7c59"),
                Attribute(name: "stroke", value: "#2d5a3a"),
                Attribute(name: "stroke-width", value: "1")
            ],
            children: []
        )
        return [AnyNode(svgContainer(className: "piece-svg-king", children: [AnyNode(circle), AnyNode(crownPath), AnyNode(shieldPath)]))]
    }

    private static func svgContainer(className: String, children: [AnyNode]) -> Element<AnyHTMLContext> {
        Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 40 40"),
                Attribute(name: "width", value: "40"),
                Attribute(name: "height", value: "40"),
                Attribute(name: "class", value: className)
            ],
            children: children
        )
    }
}
