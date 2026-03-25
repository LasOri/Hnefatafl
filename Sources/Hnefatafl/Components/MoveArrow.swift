struct MoveArrow: Equatable {
    let fromRow: Int
    let fromCol: Int
    let toRow: Int
    let toCol: Int
    let color: String

    static func from(move: Move, color: String) -> MoveArrow {
        MoveArrow(
            fromRow: move.fromRow,
            fromCol: move.fromCol,
            toRow: move.toRow,
            toCol: move.toCol,
            color: color
        )
    }

    var isHorizontal: Bool {
        fromRow == toRow
    }

    var isVertical: Bool {
        fromCol == toCol
    }
}
