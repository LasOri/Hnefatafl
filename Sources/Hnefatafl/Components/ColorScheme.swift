struct ColorScheme: Equatable {
    let boardLight: String
    let boardDark: String
    let highlightColor: String
    let name: String

    static let classic = ColorScheme(
        boardLight: "#f0d9b5",
        boardDark: "#b58863",
        highlightColor: "#ffff00",
        name: "Classic"
    )

    static let modern = ColorScheme(
        boardLight: "#dee3e6",
        boardDark: "#8ca2ad",
        highlightColor: "#5bc0de",
        name: "Modern"
    )

    static let highContrast = ColorScheme(
        boardLight: "#ffffff",
        boardDark: "#000000",
        highlightColor: "#ff0000",
        name: "High Contrast"
    )
}
