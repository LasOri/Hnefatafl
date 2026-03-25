struct BoardLabelConfig: Equatable {
    var showRows: Bool
    var showCols: Bool
    var fontSize: Int
    var position: String

    static let standard = BoardLabelConfig(
        showRows: true,
        showCols: true,
        fontSize: 12,
        position: "outside"
    )

    static let hidden = BoardLabelConfig(
        showRows: false,
        showCols: false,
        fontSize: 12,
        position: "outside"
    )
}
