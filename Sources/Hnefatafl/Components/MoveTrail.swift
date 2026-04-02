import LINKER

struct MoveTrail {
    // Use a percentage-based viewBox: 11 units across for 11 columns
    private static let gridUnits = Position.boardSize

    static func render(move: Move) -> [AnyNode] {
        // Map cell coordinates to centers: col + 0.5, row + 0.5 in unit space
        let x1 = Double(move.fromCol) + 0.5
        let y1 = Double(move.fromRow) + 0.5
        let x2 = Double(move.toCol) + 0.5
        let y2 = Double(move.toRow) + 0.5

        let vb = gridUnits

        let line = Element<AnyHTMLContext>(
            tag: "line",
            attributes: [
                Attribute(name: "x1", value: "\(x1)"),
                Attribute(name: "y1", value: "\(y1)"),
                Attribute(name: "x2", value: "\(x2)"),
                Attribute(name: "y2", value: "\(y2)"),
                Attribute(name: "stroke", value: "#c9a84c"),
                Attribute(name: "stroke-width", value: "0.15"),
                Attribute(name: "stroke-opacity", value: "0.6"),
                Attribute(name: "stroke-linecap", value: "round")
            ],
            children: []
        )

        let svg = Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "class", value: "move-trail"),
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 \(vb) \(vb)"),
                Attribute(name: "preserveAspectRatio", value: "none")
            ],
            children: [AnyNode(line)]
        )
        return [AnyNode(svg)]
    }
}
