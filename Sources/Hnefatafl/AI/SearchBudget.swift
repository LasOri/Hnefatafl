struct SearchBudget: Equatable {
    let maxNodes: Int
    private(set) var nodesUsed: Int = 0

    var remaining: Int { max(0, maxNodes - nodesUsed) }
    var isExhausted: Bool { nodesUsed >= maxNodes }
    var usagePercent: Double {
        guard maxNodes > 0 else { return 100 }
        return Double(nodesUsed) / Double(maxNodes) * 100
    }

    mutating func consume(_ count: Int = 1) { nodesUsed += count }
    mutating func reset() { nodesUsed = 0 }
}
