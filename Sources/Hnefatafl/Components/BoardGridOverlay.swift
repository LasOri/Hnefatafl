struct GridLine: Equatable {
    let start: (Int, Int)
    let end: (Int, Int)
    let color: String

    static func == (lhs: GridLine, rhs: GridLine) -> Bool {
        lhs.start.0 == rhs.start.0 &&
        lhs.start.1 == rhs.start.1 &&
        lhs.end.0 == rhs.end.0 &&
        lhs.end.1 == rhs.end.1 &&
        lhs.color == rhs.color
    }
}

struct BoardGridOverlay: Equatable {
    let defaultColor = "rgba(0,0,0,0.2)"

    func lines(for boardSize: Int) -> [GridLine] {
        var result: [GridLine] = []
        for i in 0...boardSize {
            result.append(GridLine(start: (i, 0), end: (i, boardSize), color: defaultColor))
            result.append(GridLine(start: (0, i), end: (boardSize, i), color: defaultColor))
        }
        return result
    }

    func cssLines(for boardSize: Int) -> [String] {
        lines(for: boardSize).map { line in
            "stroke: \(line.color); x1: \(line.start.0); y1: \(line.start.1); x2: \(line.end.0); y2: \(line.end.1)"
        }
    }
}
