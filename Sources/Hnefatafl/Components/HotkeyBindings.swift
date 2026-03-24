struct HotkeyBindings: Equatable {
    let mappings: [String: String]

    func action(for key: String) -> String? {
        mappings[key]
    }

    func bind(key: String, to action: String) -> HotkeyBindings {
        var newMappings = mappings
        newMappings[key] = action
        return HotkeyBindings(mappings: newMappings)
    }

    func unbind(key: String) -> HotkeyBindings {
        var newMappings = mappings
        newMappings.removeValue(forKey: key)
        return HotkeyBindings(mappings: newMappings)
    }

    static let defaults = HotkeyBindings(mappings: [
        "n": "new-game",
        "u": "undo",
        "m": "toggle-mute",
        "a": "toggle-ai",
        "d": "cycle-difficulty",
        "f": "flip-board",
        "r": "toggle-rules",
        "h": "request-hint",
        "c": "toggle-coordinates",
    ])
}
