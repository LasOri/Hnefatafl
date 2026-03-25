struct ThinkProgress: Equatable {
    let currentDepth: Int
    let nodesSearched: Int
    let elapsed: Double
    let bestMoveFound: Move?

    func percentage(of maxDepth: Int) -> Double {
        guard maxDepth > 0 else { return 0.0 }
        return Double(currentDepth) / Double(maxDepth) * 100.0
    }

    var isThinking: Bool {
        currentDepth > 0
    }

    var description: String {
        var parts = ["Depth \(currentDepth)", "\(nodesSearched) nodes"]
        if let move = bestMoveFound {
            parts.append("Best: (\(move.fromRow),\(move.fromCol))→(\(move.toRow),\(move.toCol))")
        }
        return parts.joined(separator: " | ")
    }
}
