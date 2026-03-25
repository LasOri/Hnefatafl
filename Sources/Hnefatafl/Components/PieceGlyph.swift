enum GlyphStyle: String, CaseIterable, Equatable {
    case unicode
    case ascii
    case simple
}

struct PieceGlyph: Equatable {
    let piece: Piece
    let style: GlyphStyle

    var character: String {
        switch (piece, style) {
        case (.attacker, .unicode): return "\u{2659}"
        case (.defender, .unicode): return "\u{265F}"
        case (.king, .unicode): return "\u{265A}"
        case (.attacker, .ascii): return "A"
        case (.defender, .ascii): return "D"
        case (.king, .ascii): return "K"
        case (.attacker, .simple): return "a"
        case (.defender, .simple): return "d"
        case (.king, .simple): return "k"
        }
    }

    static func glyph(for piece: Piece, style: GlyphStyle) -> PieceGlyph {
        PieceGlyph(piece: piece, style: style)
    }
}
