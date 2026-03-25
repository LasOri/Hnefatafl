enum HighlightReason: String, Equatable {
    case selected
    case legalMove
    case lastMove
    case threat
}

struct SquareHighlightData: Equatable {
    let row: Int
    let col: Int
    let reason: HighlightReason
}
