struct SoundThemeConfig: Equatable {
    let name: String
    let moveSound: String
    let captureSound: String
    let winSound: String
    let volume: Double
}

enum SoundTheme {
    static let classic = SoundThemeConfig(name: "Classic", moveSound: "move", captureSound: "capture", winSound: "victory", volume: 0.8)
    static let minimal = SoundThemeConfig(name: "Minimal", moveSound: "tap", captureSound: "click", winSound: "chime", volume: 0.5)
    static let silent = SoundThemeConfig(name: "Silent", moveSound: "", captureSound: "", winSound: "", volume: 0)

    static var allThemes: [SoundThemeConfig] { [classic, minimal, silent] }
}
