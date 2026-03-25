struct CaptureAnimationData: Equatable {
    let capturedRow: Int
    let capturedCol: Int
    let capturedPiece: Piece
    let duration: Double

    var isKingCapture: Bool {
        capturedPiece == .king
    }
}
