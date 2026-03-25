struct MoveTextStyle: Equatable {
    let fontSize: Int
    let bold: Bool
    let color: String
    let monospace: Bool

    static let standard = MoveTextStyle(
        fontSize: 14,
        bold: false,
        color: "#333333",
        monospace: true
    )

    static let compact = MoveTextStyle(
        fontSize: 11,
        bold: false,
        color: "#666666",
        monospace: true
    )

    static let highlighted = MoveTextStyle(
        fontSize: 14,
        bold: true,
        color: "#007AFF",
        monospace: true
    )
}
