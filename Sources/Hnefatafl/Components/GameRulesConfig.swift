enum RulesVariant: String, CaseIterable, Equatable {
    case copenhagen
    case hnefatafl
    case tablut
    case brandubh
}

struct GameRulesConfig: Equatable {
    let variant: RulesVariant
    let boardSize: Int
    let shieldWallCapture: Bool

    static let copenhagen = GameRulesConfig(
        variant: .copenhagen,
        boardSize: 11,
        shieldWallCapture: true
    )
}
