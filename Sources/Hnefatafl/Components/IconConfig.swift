struct IconConfig: Equatable {
    var size: Int
    var style: String
    var showShadow: Bool

    static let standard = IconConfig(
        size: 32,
        style: "flat",
        showShadow: false
    )

    static let large = IconConfig(
        size: 48,
        style: "detailed",
        showShadow: true
    )
}
