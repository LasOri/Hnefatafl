struct GameContainer: Equatable {
    var maxWidth: Int
    var centered: Bool
    var backgroundColor: String

    static let standard = GameContainer(
        maxWidth: 800,
        centered: true,
        backgroundColor: "#f5f0e8"
    )

    static let fullWidth = GameContainer(
        maxWidth: Int.max,
        centered: false,
        backgroundColor: "#ffffff"
    )
}
