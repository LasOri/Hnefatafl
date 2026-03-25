struct PieceAnimationState: Equatable {
    let isAnimating: Bool
    let animatingPiece: Piece?
    let fromRow: Int
    let fromCol: Int
    let toRow: Int
    let toCol: Int

    static let idle = PieceAnimationState(
        isAnimating: false,
        animatingPiece: nil,
        fromRow: 0,
        fromCol: 0,
        toRow: 0,
        toCol: 0
    )
}
