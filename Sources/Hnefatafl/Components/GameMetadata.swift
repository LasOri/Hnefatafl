struct GameMetadata: Equatable {
    let version: String
    let variant: String
    let createdDate: String
    let boardSize: Int

    static let currentVersion = "1.0"

    static func defaultMetadata() -> GameMetadata {
        GameMetadata(
            version: currentVersion,
            variant: "Copenhagen",
            createdDate: "",
            boardSize: Position.boardSize
        )
    }
}
