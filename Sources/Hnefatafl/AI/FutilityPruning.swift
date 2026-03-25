enum FutilityPruning {
    static let margin: Int = 200

    static func shouldPrune(staticEval: Int, alpha: Int, depth: Int) -> Bool {
        guard depth <= 2 else { return false }
        return staticEval + margin * depth < alpha
    }

    static func adjustedMargin(depth: Int) -> Int {
        margin * max(1, depth)
    }
}
