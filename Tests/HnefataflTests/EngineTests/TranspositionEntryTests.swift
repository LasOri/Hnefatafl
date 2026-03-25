import Testing
@testable import Hnefatafl

@Suite("Transposition Entry Tests")
struct TranspositionEntryTests {

    @Test("TTEntry stores depth and score")
    func storesDepthAndScore() {
        let entry = TTEntry(depth: 3, score: 100, flag: .exact)
        #expect(entry.depth == 3)
        #expect(entry.score == 100)
    }

    @Test("exact flag")
    func exactFlag() {
        let entry = TTEntry(depth: 1, score: 50, flag: .exact)
        #expect(entry.flag == .exact)
    }

    @Test("lower bound flag")
    func lowerBound() {
        let entry = TTEntry(depth: 1, score: 50, flag: .lowerBound)
        #expect(entry.flag == .lowerBound)
    }

    @Test("upper bound flag")
    func upperBound() {
        let entry = TTEntry(depth: 1, score: 50, flag: .upperBound)
        #expect(entry.flag == .upperBound)
    }

    @Test("TranspositionTable stores and retrieves")
    func storeAndRetrieve() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 42, depth: 3, score: 100, flag: .exact)
        let retrieved = table.lookup(hash: 42)
        #expect(retrieved?.score == 100)
    }

    @Test("lookup returns nil for unknown hash")
    func lookupNil() {
        let table = TranspositionTable(maxSize: 100)
        #expect(table.lookup(hash: 999) == nil)
    }

    @Test("deeper entry replaces shallower")
    func deeperReplaces() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 42, depth: 2, score: 50, flag: .exact)
        table.store(hash: 42, depth: 5, score: 200, flag: .exact)
        #expect(table.lookup(hash: 42)?.score == 200)
    }

    @Test("shallower entry does not replace deeper")
    func shallowerDoesNotReplace() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 42, depth: 5, score: 200, flag: .exact)
        table.store(hash: 42, depth: 2, score: 50, flag: .exact)
        #expect(table.lookup(hash: 42)?.score == 200)
    }

    @Test("count tracks entries")
    func countTracks() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 1, depth: 1, score: 10, flag: .exact)
        table.store(hash: 2, depth: 1, score: 20, flag: .exact)
        #expect(table.count == 2)
    }

    @Test("TTEntry is Equatable")
    func equatable() {
        let a = TTEntry(depth: 3, score: 100, flag: .exact)
        let b = TTEntry(depth: 3, score: 100, flag: .exact)
        #expect(a == b)
    }
}
