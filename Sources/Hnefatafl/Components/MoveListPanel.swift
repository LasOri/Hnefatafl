struct MoveListPanel: Equatable {
    var isExpanded: Bool
    var maxVisible: Int
    var showNumbers: Bool

    static let compact = MoveListPanel(
        isExpanded: false,
        maxVisible: 5,
        showNumbers: true
    )

    static let expanded = MoveListPanel(
        isExpanded: true,
        maxVisible: 50,
        showNumbers: true
    )
}
