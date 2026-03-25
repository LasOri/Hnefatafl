enum MenuItemType: String, CaseIterable, Equatable {
    case newGame
    case undo
    case settings
    case rules
    case about
}

struct GameMenuConfig: Equatable {
    let items: [MenuItemType]
    let isOpen: Bool

    static let defaultMenu = GameMenuConfig(
        items: MenuItemType.allCases,
        isOpen: false
    )

    static let minimalMenu = GameMenuConfig(
        items: [.newGame, .undo],
        isOpen: false
    )
}
