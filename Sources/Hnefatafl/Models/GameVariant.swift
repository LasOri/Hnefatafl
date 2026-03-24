enum EscapeType: Equatable {
    case corner
    case edge
}

struct GameVariant: Equatable {
    let boardSize: Int
    let attackerCount: Int
    let defenderCount: Int
    let kingCount: Int
    let escapeType: EscapeType
    let label: String

    static let copenhagen = GameVariant(
        boardSize: 11,
        attackerCount: 24,
        defenderCount: 12,
        kingCount: 1,
        escapeType: .corner,
        label: "Copenhagen"
    )

    static let tablut = GameVariant(
        boardSize: 9,
        attackerCount: 16,
        defenderCount: 8,
        kingCount: 1,
        escapeType: .corner,
        label: "Tablut"
    )
}
