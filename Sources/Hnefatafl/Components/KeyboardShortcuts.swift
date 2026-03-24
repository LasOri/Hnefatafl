struct KeyboardShortcut: Equatable {
    let key: String
    let description: String
    let category: String
}

struct KeyboardShortcuts {
    static let all: [KeyboardShortcut] = [
        KeyboardShortcut(key: "ArrowUp", description: "Move focus up", category: "Navigation"),
        KeyboardShortcut(key: "ArrowDown", description: "Move focus down", category: "Navigation"),
        KeyboardShortcut(key: "ArrowLeft", description: "Move focus left", category: "Navigation"),
        KeyboardShortcut(key: "ArrowRight", description: "Move focus right", category: "Navigation"),
        KeyboardShortcut(key: "Enter", description: "Select square or confirm move", category: "Navigation"),
        KeyboardShortcut(key: "Escape", description: "Deselect piece", category: "Actions"),
    ]
}
