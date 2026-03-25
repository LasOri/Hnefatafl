struct GameLayoutConfig: Equatable {
    var boardSize: Int
    var sidebarWidth: Int
    var headerHeight: Int
    var footerHeight: Int

    var totalWidth: Int {
        boardSize + sidebarWidth
    }

    var totalHeight: Int {
        boardSize + headerHeight + footerHeight
    }

    static let standard = GameLayoutConfig(
        boardSize: 440,
        sidebarWidth: 200,
        headerHeight: 60,
        footerHeight: 40
    )

    static let compact = GameLayoutConfig(
        boardSize: 320,
        sidebarWidth: 150,
        headerHeight: 40,
        footerHeight: 30
    )
}
