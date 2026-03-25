struct ArrowConfig: Equatable {
    let from: (Int, Int)
    let to: (Int, Int)
    let color: String
    let width: Double

    var cssStyle: String {
        let dx = to.1 - from.1
        let dy = to.0 - from.0
        return "stroke: \(color); stroke-width: \(width)px; vector: (\(dx), \(dy))"
    }

    static func == (lhs: ArrowConfig, rhs: ArrowConfig) -> Bool {
        lhs.from.0 == rhs.from.0 &&
        lhs.from.1 == rhs.from.1 &&
        lhs.to.0 == rhs.to.0 &&
        lhs.to.1 == rhs.to.1 &&
        lhs.color == rhs.color &&
        lhs.width == rhs.width
    }
}
