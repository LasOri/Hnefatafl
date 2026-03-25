struct BoardThemeConfig: Equatable {
    let name: String
    let cellSize: Int
    let showCoords: Bool
    let darkSquare: String
    let lightSquare: String

    static let defaultTheme = BoardThemeConfig(
        name: "Classic",
        cellSize: 48,
        showCoords: true,
        darkSquare: "#8B7355",
        lightSquare: "#D2B48C"
    )

    static let compactTheme = BoardThemeConfig(
        name: "Compact",
        cellSize: 32,
        showCoords: false,
        darkSquare: "#6B5B45",
        lightSquare: "#C4A882"
    )
}
