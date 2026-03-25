struct GameDebugPanel: Equatable {
    let isVisible: Bool
    let evalScore: Int
    let nodeCount: Int
    let searchDepth: Int

    var summary: String {
        "Eval: \(evalScore) | Nodes: \(nodeCount) | Depth: \(searchDepth)"
    }
}
