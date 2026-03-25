struct BoardPadding: Equatable {
    let top: Int
    let right: Int
    let bottom: Int
    let left: Int

    var horizontal: Int { left + right }
    var vertical: Int { top + bottom }

    static let standard = BoardPadding(top: 8, right: 8, bottom: 8, left: 8)
    static let none = BoardPadding(top: 0, right: 0, bottom: 0, left: 0)
}
