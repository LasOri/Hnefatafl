struct PieceIcon: Equatable {
    let piece: Piece
    let symbol: String
    let altText: String

    static func icon(for piece: Piece) -> PieceIcon {
        switch piece {
        case .attacker:
            return PieceIcon(piece: .attacker, symbol: "\u{2694}", altText: "Attacker")
        case .defender:
            return PieceIcon(piece: .defender, symbol: "\u{1F6E1}", altText: "Defender")
        case .king:
            return PieceIcon(piece: .king, symbol: "\u{265A}", altText: "King")
        }
    }

    static let allIcons: [PieceIcon] = [
        icon(for: .attacker),
        icon(for: .defender),
        icon(for: .king)
    ]
}
