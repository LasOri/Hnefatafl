struct ToolbarItem: Equatable {
    let id: String
    let icon: String
    let tooltip: String
    let enabled: Bool
}

enum ToolbarConfig {
    static func items(gameInProgress: Bool, canUndo: Bool) -> [ToolbarItem] {
        [
            ToolbarItem(id: "new", icon: "plus", tooltip: "New Game", enabled: true),
            ToolbarItem(id: "undo", icon: "arrow-left", tooltip: "Undo", enabled: canUndo && gameInProgress),
            ToolbarItem(id: "settings", icon: "gear", tooltip: "Settings", enabled: true),
            ToolbarItem(id: "help", icon: "question", tooltip: "Help", enabled: true),
        ]
    }
}
