struct AboutData: Equatable {
    let appName: String
    let version: String
    let description: String
}

enum AboutInfo {
    static let data = AboutData(
        appName: "Hnefatafl",
        version: "1.0.0",
        description: "A Viking board game of strategy"
    )
}
