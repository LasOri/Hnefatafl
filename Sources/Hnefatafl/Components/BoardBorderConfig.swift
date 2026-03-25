struct BoardBorderConfig: Equatable {
    var width: Int
    var color: String
    var cornerRadius: Int
    var showShadow: Bool

    static let standard = BoardBorderConfig(
        width: 2,
        color: "#4a3728",
        cornerRadius: 4,
        showShadow: true
    )

    static let minimal = BoardBorderConfig(
        width: 1,
        color: "#999999",
        cornerRadius: 0,
        showShadow: false
    )
}
