import LINKER

struct MoveTrail {
    private static let cellSize = 40
    private static let viewBoxSize = Position.boardSize * cellSize

    static func render(move: Move) -> [AnyNode] {
        let x1 = move.fromCol * cellSize + cellSize / 2
        let y1 = move.fromRow * cellSize + cellSize / 2
        let x2 = move.toCol * cellSize + cellSize / 2
        let y2 = move.toRow * cellSize + cellSize / 2

        let line = Element<AnyHTMLContext>(
            tag: "line",
            attributes: [
                Attribute(name: "x1", value: "\(x1)"),
                Attribute(name: "y1", value: "\(y1)"),
                Attribute(name: "x2", value: "\(x2)"),
                Attribute(name: "y2", value: "\(y2)"),
                Attribute(name: "stroke", value: "#c9a84c"),
                Attribute(name: "stroke-width", value: "3"),
                Attribute(name: "stroke-opacity", value: "0.6")
            ],
            children: []
        )

        let svg = Element<AnyHTMLContext>(
            tag: "svg",
            attributes: [
                Attribute(name: "class", value: "move-trail"),
                Attribute(name: "xmlns", value: "http://www.w3.org/2000/svg"),
                Attribute(name: "viewBox", value: "0 0 \(viewBoxSize) \(viewBoxSize)")
            ],
            children: [AnyNode(line)]
        )
        return [AnyNode(svg)]
    }
}
