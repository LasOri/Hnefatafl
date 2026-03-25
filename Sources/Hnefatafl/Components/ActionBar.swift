struct ActionItem: Equatable {
    let id: String
    let label: String
    let enabled: Bool
}

enum ActionBar {
    static func items(canUndo: Bool, canRedo: Bool, gameOver: Bool) -> [ActionItem] {
        [
            ActionItem(id: "undo", label: "Undo", enabled: canUndo && !gameOver),
            ActionItem(id: "redo", label: "Redo", enabled: canRedo && !gameOver),
            ActionItem(id: "new-game", label: "New Game", enabled: true),
            ActionItem(id: "settings", label: "Settings", enabled: true)
        ]
    }
}
