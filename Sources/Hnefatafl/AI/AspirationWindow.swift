struct AspirationWindow: Equatable {
    static let defaultSize = 50

    let alpha: Int
    let beta: Int

    init(previousScore: Int, size: Int = defaultSize) {
        self.alpha = previousScore - size
        self.beta = previousScore + size
    }

    private init(alpha: Int, beta: Int) {
        self.alpha = alpha
        self.beta = beta
    }

    func contains(score: Int) -> Bool {
        score > alpha && score < beta
    }

    func widen() -> AspirationWindow {
        AspirationWindow(alpha: alpha - Self.defaultSize, beta: beta + Self.defaultSize)
    }

    func handleFailLow() -> AspirationWindow {
        AspirationWindow(alpha: alpha - Self.defaultSize, beta: beta)
    }

    func handleFailHigh() -> AspirationWindow {
        AspirationWindow(alpha: alpha, beta: beta + Self.defaultSize)
    }
}
