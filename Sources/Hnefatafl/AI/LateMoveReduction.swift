struct LateMoveReduction {
    static let moveThreshold = 4
    static let minimumDepth = 3
    static let maxReduction = 2

    static func reduction(moveIndex: Int, depth: Int) -> Int {
        guard depth >= minimumDepth, moveIndex >= moveThreshold else { return 0 }
        return min(1 + (moveIndex > 8 ? 1 : 0), maxReduction)
    }

    static func shouldReduce(moveIndex: Int, depth: Int, isCapture: Bool) -> Bool {
        guard !isCapture else { return false }
        return reduction(moveIndex: moveIndex, depth: depth) > 0
    }
}
