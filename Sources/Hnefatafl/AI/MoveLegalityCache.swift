struct MoveLegalityCache: Equatable {
    private var cache: [CacheKey: Bool]

    init() {
        self.cache = [:]
    }

    mutating func store(row: Int, col: Int, isLegal: Bool) {
        let key = CacheKey(row: row, col: col)
        cache[key] = isLegal
    }

    func lookup(row: Int, col: Int) -> Bool? {
        let key = CacheKey(row: row, col: col)
        return cache[key]
    }

    mutating func clear() {
        cache.removeAll()
    }
}

private struct CacheKey: Hashable {
    let row: Int
    let col: Int
}
