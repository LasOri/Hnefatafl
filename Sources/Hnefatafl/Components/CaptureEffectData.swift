struct CaptureEffectData: Equatable {
    let row: Int
    let col: Int
    let piece: Piece
    let effectType: String

    var isKingCapture: Bool { piece == .king }

    static func standard(row: Int, col: Int, piece: Piece) -> CaptureEffectData {
        CaptureEffectData(row: row, col: col, piece: piece, effectType: "standard")
    }
}
