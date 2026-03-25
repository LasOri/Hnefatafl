struct MoveGenCache {
    private var entries: [UInt64: [Move]] = [:]
    private(set) var hits = 0
    private(set) var misses = 0

    mutating func store(hash: UInt64, moves: [Move]) {
        entries[hash] = moves
    }

    mutating func lookup(hash: UInt64) -> [Move]? {
        if let result = entries[hash] {
            hits += 1
            return result
        }
        misses += 1
        return nil
    }

    mutating func clear() {
        entries.removeAll()
        hits = 0
        misses = 0
    }

    var hitRate: Double {
        let total = hits + misses
        guard total > 0 else { return 0 }
        return Double(hits) / Double(total)
    }
}
