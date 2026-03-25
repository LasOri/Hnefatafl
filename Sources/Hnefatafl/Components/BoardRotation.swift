enum BoardRotation: Int, CaseIterable, Equatable {
    case none = 0
    case quarter = 90
    case half = 180
    case threeQuarter = 270

    var degrees: Int { rawValue }

    var next: BoardRotation {
        let all = BoardRotation.allCases
        let idx = all.firstIndex(of: self)!
        return all[(idx + 1) % all.count]
    }

    var cssTransform: String {
        "rotate(\(degrees)deg)"
    }

    func transform(row: Int, col: Int, boardSize: Int) -> (Int, Int) {
        let max = boardSize - 1
        switch self {
        case .none: return (row, col)
        case .quarter: return (col, max - row)
        case .half: return (max - row, max - col)
        case .threeQuarter: return (max - col, row)
        }
    }
}
