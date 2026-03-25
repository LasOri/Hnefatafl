struct NodeCounter: Equatable {
    private(set) var leafNodes: Int = 0
    private(set) var interiorNodes: Int = 0
    var totalNodes: Int { leafNodes + interiorNodes }

    mutating func recordLeaf() { leafNodes += 1 }
    mutating func recordInterior() { interiorNodes += 1 }
    mutating func reset() { leafNodes = 0; interiorNodes = 0 }

    var branchingFactor: Double {
        guard interiorNodes > 0 else { return 0 }
        return Double(totalNodes) / Double(interiorNodes)
    }
}
