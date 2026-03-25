struct BoardColorScheme: Equatable {
    let name: String
    let lightSquare: String
    let darkSquare: String
    let selectedSquare: String
    let legalMoveIndicator: String
}

enum ThemeColors {
    static let classic = BoardColorScheme(
        name: "Classic", lightSquare: "#f0d9b5", darkSquare: "#b58863",
        selectedSquare: "#ffff00", legalMoveIndicator: "#00ff0080"
    )
    static let dark = BoardColorScheme(
        name: "Dark", lightSquare: "#4a4a4a", darkSquare: "#2a2a2a",
        selectedSquare: "#ff8800", legalMoveIndicator: "#00aaff80"
    )
    static let nordic = BoardColorScheme(
        name: "Nordic", lightSquare: "#e8dcc8", darkSquare: "#8b7355",
        selectedSquare: "#4488cc", legalMoveIndicator: "#cc444480"
    )
    static var allThemes: [BoardColorScheme] { [classic, dark, nordic] }
}
