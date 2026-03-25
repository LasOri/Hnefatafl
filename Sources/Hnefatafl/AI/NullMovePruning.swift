struct NullMovePruning {
    static let minimumDepth = 3

    static func shouldAttempt(depth: Int, inCheck: Bool) -> Bool {
        !inCheck && depth >= minimumDepth
    }

    static func reduction(depth: Int) -> Int {
        guard depth >= minimumDepth else { return 0 }
        return 2
    }
}
