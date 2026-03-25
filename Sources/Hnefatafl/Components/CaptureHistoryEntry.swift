struct CaptureHistoryEntry: Equatable {
    let moveNumber: Int
    let capturedPiece: Piece
    let row: Int
    let col: Int
    let capturedBy: Player

    var description: String {
        let pieceLabel: String
        switch capturedPiece {
        case .attacker: pieceLabel = "Attacker"
        case .defender: pieceLabel = "Defender"
        case .king: pieceLabel = "King"
        }
        let capturer = capturedBy == .attacker ? "Attacker" : "Defender"
        return "Move \(moveNumber): \(capturer) captured \(pieceLabel) at (\(row), \(col))"
    }
}
