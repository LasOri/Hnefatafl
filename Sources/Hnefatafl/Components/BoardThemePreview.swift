struct BoardThemePreview: Equatable {
    let name: String
    let lightColor: String
    let darkColor: String
    let accentColor: String

    static let themes: [BoardThemePreview] = [
        BoardThemePreview(
            name: "Classic",
            lightColor: "#F5DEB3",
            darkColor: "#8B7355",
            accentColor: "#DAA520"
        ),
        BoardThemePreview(
            name: "Nordic",
            lightColor: "#E8E0D0",
            darkColor: "#4A6741",
            accentColor: "#2E5090"
        ),
        BoardThemePreview(
            name: "Midnight",
            lightColor: "#B0C4DE",
            darkColor: "#2F4F4F",
            accentColor: "#FF6347"
        ),
    ]
}
