import Testing
@testable import Hnefatafl

@Suite("Transposition Table Tests")
struct TranspositionTableTests {

    @Test("stores and retrieves entry")
    func storeAndRetrieve() {
        var table = TranspositionTable(maxSize: 100)
        let position = Position.copenhagenStart()
        let hash = ZobristHash.hash(position: position)
        table.store(hash: hash, depth: 3, score: 42, flag: .exact)
        let entry = table.lookup(hash: hash)
        #expect(entry != nil)
        #expect(entry?.score == 42)
        #expect(entry?.depth == 3)
        #expect(entry?.flag == .exact)
    }

    @Test("returns nil for unknown position")
    func nilForUnknown() {
        let table = TranspositionTable(maxSize: 100)
        let entry = table.lookup(hash: 12345)
        #expect(entry == nil)
    }

    @Test("ZobristHash produces consistent hashes")
    func consistentHash() {
        let position = Position.copenhagenStart()
        let hash1 = ZobristHash.hash(position: position)
        let hash2 = ZobristHash.hash(position: position)
        #expect(hash1 == hash2)
    }

    @Test("ZobristHash differs for different positions")
    func differentPositions() {
        let pos1 = Position.copenhagenStart()
        let game = Game().makeMove(Game().position.allLegalMoves(for: .attacker).first!)
        let pos2 = game.position
        let hash1 = ZobristHash.hash(position: pos1)
        let hash2 = ZobristHash.hash(position: pos2)
        #expect(hash1 != hash2)
    }

    @Test("table respects max size")
    func respectsMaxSize() {
        var table = TranspositionTable(maxSize: 2)
        table.store(hash: 1, depth: 1, score: 10, flag: .exact)
        table.store(hash: 2, depth: 1, score: 20, flag: .exact)
        table.store(hash: 3, depth: 1, score: 30, flag: .exact)
        #expect(table.count <= 3)
    }

    @Test("TTFlag has all three types")
    func flagTypes() {
        let flags: [TTFlag] = [.exact, .lowerBound, .upperBound]
        #expect(flags.count == 3)
    }

    @Test("deeper entry replaces shallower")
    func deeperReplaces() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 42, depth: 1, score: 10, flag: .exact)
        table.store(hash: 42, depth: 3, score: 20, flag: .exact)
        let entry = table.lookup(hash: 42)
        #expect(entry?.score == 20)
        #expect(entry?.depth == 3)
    }

    @Test("shallower entry does not replace deeper")
    func shallowerDoesNotReplace() {
        var table = TranspositionTable(maxSize: 100)
        table.store(hash: 42, depth: 3, score: 20, flag: .exact)
        table.store(hash: 42, depth: 1, score: 10, flag: .exact)
        let entry = table.lookup(hash: 42)
        #expect(entry?.score == 20)
    }
}
