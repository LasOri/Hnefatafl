enum NotationStyle: String, CaseIterable, Equatable {
    case algebraic
    case coordinate
    case descriptive
}

struct NotationDisplay: Equatable {
    let style: NotationStyle
    let showMoveNumbers: Bool
    let highlightLast: Bool

    init(style: NotationStyle = .algebraic, showMoveNumbers: Bool = true, highlightLast: Bool = true) {
        self.style = style
        self.showMoveNumbers = showMoveNumbers
        self.highlightLast = highlightLast
    }
}
