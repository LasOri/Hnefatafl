struct GameSidebar: Equatable {
    let isVisible: Bool
    let width: Int
    let showAnalysis: Bool
    let showHistory: Bool

    static let collapsed = GameSidebar(isVisible: false, width: 0, showAnalysis: false, showHistory: false)
    static let expanded = GameSidebar(isVisible: true, width: 280, showAnalysis: true, showHistory: true)
}
