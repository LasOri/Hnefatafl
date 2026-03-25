struct GameFooter: Equatable {
    let showMoveList: Bool
    let showTimer: Bool
    let height: Int

    static let minimal = GameFooter(showMoveList: false, showTimer: false, height: 32)
    static let full = GameFooter(showMoveList: true, showTimer: true, height: 120)
}
