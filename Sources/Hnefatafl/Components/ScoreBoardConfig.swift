struct ScoreBoardConfig: Equatable {
    let showMaterial: Bool
    let showEval: Bool
    let showClock: Bool
    let position: String

    static let standard = ScoreBoardConfig(
        showMaterial: true,
        showEval: true,
        showClock: true,
        position: "top"
    )

    static let minimal = ScoreBoardConfig(
        showMaterial: true,
        showEval: false,
        showClock: false,
        position: "top"
    )
}
