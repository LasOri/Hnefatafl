struct SearchStatistics: Equatable {
    var nodesVisited: Int
    var cutoffs: Int
    var ttHits: Int
    var ttMisses: Int
    var depthReached: Int
    var elapsed: Double

    init() {
        self.nodesVisited = 0
        self.cutoffs = 0
        self.ttHits = 0
        self.ttMisses = 0
        self.depthReached = 0
        self.elapsed = 0.0
    }

    mutating func recordNode() {
        nodesVisited += 1
    }

    mutating func recordCutoff() {
        cutoffs += 1
    }

    mutating func recordTTHit() {
        ttHits += 1
    }

    mutating func recordTTMiss() {
        ttMisses += 1
    }

    mutating func updateDepth(_ depth: Int) {
        if depth > depthReached {
            depthReached = depth
        }
    }

    mutating func recordElapsed(_ time: Double) {
        elapsed = time
    }

    mutating func reset() {
        nodesVisited = 0
        cutoffs = 0
        ttHits = 0
        ttMisses = 0
        depthReached = 0
        elapsed = 0.0
    }
}
