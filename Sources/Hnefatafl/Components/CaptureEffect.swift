import LINKER

struct CaptureEffect {
    private static let particleCount = 4

    static func render(row: Int, col: Int) -> [AnyNode] {
        var particles: [AnyNode] = []
        for i in 0..<particleCount {
            let particle = Element<AnyHTMLContext>(
                tag: "div",
                attributes: [
                    Attribute(name: "class", value: "particle particle-\(i)")
                ],
                children: []
            )
            particles.append(AnyNode(particle))
        }

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "capture-effect"),
                Attribute(name: "data-row", value: "\(row)"),
                Attribute(name: "data-col", value: "\(col)")
            ],
            children: particles
        )
        return [AnyNode(container)]
    }
}
