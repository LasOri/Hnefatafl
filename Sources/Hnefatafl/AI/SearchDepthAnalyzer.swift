struct DepthRecord: Equatable {
    let requestedDepth: Int
    let actualDepth: Int
    let nodesSearched: Int
}

struct SearchDepthAnalyzer: Equatable {
    private(set) var records: [DepthRecord] = []

    var recordCount: Int { records.count }

    var averageActualDepth: Double {
        guard !records.isEmpty else { return 0.0 }
        return Double(records.reduce(0) { $0 + $1.actualDepth }) / Double(records.count)
    }

    var averageNodesSearched: Double {
        guard !records.isEmpty else { return 0.0 }
        return Double(records.reduce(0) { $0 + $1.nodesSearched }) / Double(records.count)
    }

    var maxDepthReached: Int {
        records.map(\.actualDepth).max() ?? 0
    }

    var totalNodesSearched: Int {
        records.reduce(0) { $0 + $1.nodesSearched }
    }

    var depthEfficiency: Double {
        guard !records.isEmpty else { return 0.0 }
        let totalRequested = records.reduce(0) { $0 + $1.requestedDepth }
        let totalActual = records.reduce(0) { $0 + $1.actualDepth }
        guard totalRequested > 0 else { return 0.0 }
        return Double(totalActual) / Double(totalRequested)
    }

    mutating func record(requestedDepth: Int, actualDepth: Int, nodesSearched: Int) {
        records.append(DepthRecord(requestedDepth: requestedDepth, actualDepth: actualDepth, nodesSearched: nodesSearched))
    }

    mutating func clear() {
        records.removeAll()
    }
}
