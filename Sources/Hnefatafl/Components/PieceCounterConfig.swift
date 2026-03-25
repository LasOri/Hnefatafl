struct PieceCounterConfig: Equatable {
    let showAttackers: Bool
    let showDefenders: Bool
    let showKing: Bool
    let compact: Bool

    static let full = PieceCounterConfig(
        showAttackers: true,
        showDefenders: true,
        showKing: true,
        compact: false
    )

    static let minimal = PieceCounterConfig(
        showAttackers: true,
        showDefenders: true,
        showKing: false,
        compact: true
    )
}
