struct ThemePreset: Equatable {
    let name: String
    let lightSquare: String
    let darkSquare: String
    let attackerColor: String
    let defenderColor: String
    let kingColor: String
    let backgroundColor: String
}

enum ThemeRegistry {
    static let viking = ThemePreset(
        name: "Viking",
        lightSquare: "#f0d9b5",
        darkSquare: "#b58863",
        attackerColor: "#c0392b",
        defenderColor: "#2980b9",
        kingColor: "#f1c40f",
        backgroundColor: "#2c3e50"
    )

    static let classic = ThemePreset(
        name: "Classic",
        lightSquare: "#eeeed2",
        darkSquare: "#769656",
        attackerColor: "#333333",
        defenderColor: "#eeeeee",
        kingColor: "#ffd700",
        backgroundColor: "#312e2b"
    )

    static let modern = ThemePreset(
        name: "Modern",
        lightSquare: "#e8e8e8",
        darkSquare: "#7b7b7b",
        attackerColor: "#e74c3c",
        defenderColor: "#3498db",
        kingColor: "#f39c12",
        backgroundColor: "#1a1a2e"
    )

    static let highContrast = ThemePreset(
        name: "High Contrast",
        lightSquare: "#ffffff",
        darkSquare: "#000000",
        attackerColor: "#ff0000",
        defenderColor: "#0000ff",
        kingColor: "#ffff00",
        backgroundColor: "#333333"
    )

    static let allThemes: [ThemePreset] = [viking, classic, modern, highContrast]

    static let defaultTheme: ThemePreset = viking

    static func theme(named name: String) -> ThemePreset? {
        allThemes.first { $0.name == name }
    }
}
