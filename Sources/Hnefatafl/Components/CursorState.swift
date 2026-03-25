struct CursorState: Equatable {
    var hoveredRow: Int?
    var hoveredCol: Int?
    var isOverPiece: Bool

    var hasHover: Bool {
        hoveredRow != nil && hoveredCol != nil
    }

    static let none = CursorState(
        hoveredRow: nil,
        hoveredCol: nil,
        isOverPiece: false
    )
}
