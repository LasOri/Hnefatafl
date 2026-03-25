struct EvalCache {
    private var entries: [UInt64: Int] = [:]

    var count: Int { entries.count }

    mutating func store(hash: UInt64, score: Int) {
        entries[hash] = score
    }

    func lookup(hash: UInt64) -> Int? {
        entries[hash]
    }

    mutating func clear() {
        entries.removeAll()
    }
}
