struct GamePaletteConfig: Equatable {
    let primary: String
    let secondary: String
    let accent: String
    let background: String

    static let light = GamePaletteConfig(
        primary: "#333333",
        secondary: "#666666",
        accent: "#007AFF",
        background: "#FFFFFF"
    )

    static let dark = GamePaletteConfig(
        primary: "#EEEEEE",
        secondary: "#AAAAAA",
        accent: "#0A84FF",
        background: "#1C1C1E"
    )
}
