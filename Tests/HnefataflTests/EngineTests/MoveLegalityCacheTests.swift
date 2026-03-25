import Testing
@testable import Hnefatafl

@Suite("MoveLegalityCache Tests")
struct MoveLegalityCacheTests {
    @Test("Lookup empty cache returns nil")
    func lookupEmpty() {
        let cache = MoveLegalityCache()
        #expect(cache.lookup(row: 5, col: 5) == nil)
    }

    @Test("Store and lookup legal move")
    func storeLegal() {
        var cache = MoveLegalityCache()
        cache.store(row: 5, col: 5, isLegal: true)
        #expect(cache.lookup(row: 5, col: 5) == true)
    }

    @Test("Store and lookup illegal move")
    func storeIllegal() {
        var cache = MoveLegalityCache()
        cache.store(row: 3, col: 7, isLegal: false)
        #expect(cache.lookup(row: 3, col: 7) == false)
    }

    @Test("Different positions return different values")
    func differentPositions() {
        var cache = MoveLegalityCache()
        cache.store(row: 1, col: 1, isLegal: true)
        cache.store(row: 1, col: 2, isLegal: false)

        #expect(cache.lookup(row: 1, col: 1) == true)
        #expect(cache.lookup(row: 1, col: 2) == false)
    }

    @Test("Clear removes all entries")
    func clear() {
        var cache = MoveLegalityCache()
        cache.store(row: 5, col: 5, isLegal: true)
        cache.store(row: 3, col: 7, isLegal: false)

        cache.clear()
        #expect(cache.lookup(row: 5, col: 5) == nil)
        #expect(cache.lookup(row: 3, col: 7) == nil)
    }

    @Test("Overwrite existing entry")
    func overwrite() {
        var cache = MoveLegalityCache()
        cache.store(row: 5, col: 5, isLegal: true)
        cache.store(row: 5, col: 5, isLegal: false)
        #expect(cache.lookup(row: 5, col: 5) == false)
    }
}
