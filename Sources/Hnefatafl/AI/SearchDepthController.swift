struct DepthConfig: Equatable {
    let minDepth: Int
    let maxDepth: Int
    let currentDepth: Int
}

enum SearchDepthController {
    static func configure(basePieces: Int, currentPieces: Int, baseDepth: Int) -> DepthConfig {
        let ratio = currentPieces > 0 ? Double(basePieces) / Double(currentPieces) : 2.0
        let bonus = ratio > 1.5 ? 2 : (ratio > 1.2 ? 1 : 0)
        let current = baseDepth + bonus
        return DepthConfig(
            minDepth: baseDepth,
            maxDepth: baseDepth + 3,
            currentDepth: min(current, baseDepth + 3)
        )
    }
}
