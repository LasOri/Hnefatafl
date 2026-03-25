struct LegalMoveCache {
    private var cache: [CacheKey: [Move]] = [:]
    private var insertionOrder: [CacheKey] = []
    let capacity: Int

    init(capacity: Int = 10000) {
        self.capacity = capacity
    }

    private struct CacheKey: Hashable {
        let fingerprint: UInt64
        let player: Player
    }

    func get(position: Position, player: Player) -> [Move]? {
        let key = makeKey(position: position, player: player)
        return cache[key]
    }

    mutating func store(position: Position, player: Player, moves: [Move]) {
        let key = makeKey(position: position, player: player)
        if cache[key] == nil {
            insertionOrder.append(key)
        }
        cache[key] = moves
        evictIfNeeded()
    }

    mutating func getOrCompute(position: Position, player: Player, compute: () -> [Move]) -> [Move] {
        if let cached = get(position: position, player: player) {
            return cached
        }
        let moves = compute()
        store(position: position, player: player, moves: moves)
        return moves
    }

    mutating func clear() {
        cache.removeAll()
        insertionOrder.removeAll()
    }

    var count: Int { cache.count }

    private func makeKey(position: Position, player: Player) -> CacheKey {
        CacheKey(fingerprint: PositionFingerprint.compute(position), player: player)
    }

    private mutating func evictIfNeeded() {
        while cache.count > capacity, !insertionOrder.isEmpty {
            let oldest = insertionOrder.removeFirst()
            cache.removeValue(forKey: oldest)
        }
    }
}
