struct SearchWindow: Equatable {
    var alpha: Int
    var beta: Int

    var width: Int { beta - alpha }
    var isClosed: Bool { alpha >= beta }

    static var full: SearchWindow { SearchWindow(alpha: Int.min / 2, beta: Int.max / 2) }
    static var null: SearchWindow { SearchWindow(alpha: 0, beta: 1) }

    func negated() -> SearchWindow {
        SearchWindow(alpha: -beta, beta: -alpha)
    }

    func narrowed(by margin: Int) -> SearchWindow {
        SearchWindow(alpha: alpha + margin, beta: beta - margin)
    }
}
