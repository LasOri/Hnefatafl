struct SearchDebugInfo: Equatable {
    var nodesSearched: Int = 0
    var maxDepthReached: Int = 0
    var cutoffs: Int = 0
    var ttHits: Int = 0
    var bestScore: Int = 0

    mutating func recordNode() { nodesSearched += 1 }
    mutating func recordCutoff() { cutoffs += 1 }
    mutating func recordTTHit() { ttHits += 1 }
    mutating func updateDepth(_ depth: Int) { maxDepthReached = max(maxDepthReached, depth) }
    mutating func updateScore(_ score: Int) { bestScore = score }

    var cutoffRate: Double {
        guard nodesSearched > 0 else { return 0 }
        return Double(cutoffs) / Double(nodesSearched) * 100
    }
}
