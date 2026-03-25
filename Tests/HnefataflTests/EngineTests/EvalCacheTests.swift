import Testing
@testable import Hnefatafl

@Suite("Evaluation Cache Tests")
struct EvalCacheTests {

    @Test("cache miss returns nil")
    func cacheMiss() {
        let cache = EvalCache()
        #expect(cache.lookup(hash: 123) == nil)
    }

    @Test("stores and retrieves score")
    func storeAndRetrieve() {
        var cache = EvalCache()
        cache.store(hash: 42, score: 150)
        #expect(cache.lookup(hash: 42) == 150)
    }

    @Test("clear empties cache")
    func clear() {
        var cache = EvalCache()
        cache.store(hash: 42, score: 150)
        cache.clear()
        #expect(cache.lookup(hash: 42) == nil)
    }

    @Test("count tracks entries")
    func count() {
        var cache = EvalCache()
        cache.store(hash: 1, score: 10)
        cache.store(hash: 2, score: 20)
        #expect(cache.count == 2)
    }

    @Test("overwrite updates score")
    func overwrite() {
        var cache = EvalCache()
        cache.store(hash: 42, score: 100)
        cache.store(hash: 42, score: 200)
        #expect(cache.lookup(hash: 42) == 200)
    }
}
