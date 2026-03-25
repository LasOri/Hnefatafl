import Testing
@testable import Hnefatafl

@Suite("Move Generation Cache Tests")
struct MoveGenCacheTests {

    @Test("cache miss returns nil")
    func cacheMiss() {
        var cache = MoveGenCache()
        #expect(cache.lookup(hash: 123) == nil)
    }

    @Test("cache stores and retrieves moves")
    func storeAndRetrieve() {
        var cache = MoveGenCache()
        let moves = [Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)]
        cache.store(hash: 42, moves: moves)
        #expect(cache.lookup(hash: 42) != nil)
        #expect(cache.lookup(hash: 42)!.count == 1)
    }

    @Test("different hashes independent")
    func independent() {
        var cache = MoveGenCache()
        let m1 = [Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)]
        let m2 = [Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)]
        cache.store(hash: 1, moves: m1)
        cache.store(hash: 2, moves: m2)
        #expect(cache.lookup(hash: 1)!.first! != cache.lookup(hash: 2)!.first!)
    }

    @Test("clear empties cache")
    func clear() {
        var cache = MoveGenCache()
        cache.store(hash: 42, moves: [])
        cache.clear()
        #expect(cache.lookup(hash: 42) == nil)
    }

    @Test("hit count tracks lookups")
    func hitCount() {
        var cache = MoveGenCache()
        cache.store(hash: 42, moves: [])
        _ = cache.lookup(hash: 42)
        _ = cache.lookup(hash: 42)
        #expect(cache.hits >= 2)
    }

    @Test("miss count tracks misses")
    func missCount() {
        var cache = MoveGenCache()
        _ = cache.lookup(hash: 999)
        #expect(cache.misses >= 1)
    }

    @Test("hit rate computed")
    func hitRate() {
        var cache = MoveGenCache()
        cache.store(hash: 42, moves: [])
        _ = cache.lookup(hash: 42)
        _ = cache.lookup(hash: 999)
        #expect(cache.hitRate >= 0 && cache.hitRate <= 1.0)
    }
}
