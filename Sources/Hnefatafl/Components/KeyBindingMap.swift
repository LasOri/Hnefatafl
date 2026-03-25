struct KeyBinding: Equatable {
    let key: String
    let action: String
    let description: String
}

enum KeyBindingMap {
    static let bindings: [KeyBinding] = [
        KeyBinding(key: "z", action: "undo", description: "Undo last move"),
        KeyBinding(key: "y", action: "redo", description: "Redo move"),
        KeyBinding(key: "n", action: "new-game", description: "New game"),
        KeyBinding(key: "h", action: "help", description: "Toggle help"),
        KeyBinding(key: "Escape", action: "deselect", description: "Deselect piece")
    ]

    static var count: Int { bindings.count }

    static func action(forKey key: String) -> String? {
        bindings.first { $0.key == key }?.action
    }
}
