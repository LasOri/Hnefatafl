import Testing
@testable import Hnefatafl

@Suite("LegalMoveCache Tests")
struct LegalMoveCacheTests {

    @Test("cache miss returns nil")
    func cacheMiss() {
        let cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        #expect(cache.get(position: pos, player: .attacker) == nil)
    }

    @Test("cache hit returns stored moves")
    func cacheHit() {
        var cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        cache.store(position: pos, player: .attacker, moves: moves)
        let cached = cache.get(position: pos, player: .attacker)
        #expect(cached != nil)
        #expect(cached!.count == moves.count)
    }

    @Test("different players have different entries")
    func differentPlayers() {
        var cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        let attackerMoves = pos.allLegalMoves(for: .attacker)
        let defenderMoves = pos.allLegalMoves(for: .defender)
        cache.store(position: pos, player: .attacker, moves: attackerMoves)
        cache.store(position: pos, player: .defender, moves: defenderMoves)
        #expect(cache.get(position: pos, player: .attacker)?.count == attackerMoves.count)
        #expect(cache.get(position: pos, player: .defender)?.count == defenderMoves.count)
    }

    @Test("clear empties cache")
    func clear() {
        var cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        cache.store(position: pos, player: .attacker, moves: [])
        cache.clear()
        #expect(cache.get(position: pos, player: .attacker) == nil)
    }

    @Test("count tracks entries")
    func count() {
        var cache = LegalMoveCache()
        #expect(cache.count == 0)
        let pos = Position.copenhagenStart()
        cache.store(position: pos, player: .attacker, moves: [])
        #expect(cache.count == 1)
    }

    @Test("eviction when capacity exceeded")
    func eviction() {
        var cache = LegalMoveCache(capacity: 2)
        let pos1 = Position.copenhagenStart()
        let pos2 = pos1.applyMove(pos1.allLegalMoves(for: .attacker)[0])
        let pos3 = pos1.applyMove(pos1.allLegalMoves(for: .attacker)[1])
        cache.store(position: pos1, player: .attacker, moves: [])
        cache.store(position: pos2, player: .attacker, moves: [])
        cache.store(position: pos3, player: .attacker, moves: [])
        #expect(cache.count <= 2)
    }

    @Test("getOrCompute returns cached on hit")
    func getOrComputeHit() {
        var cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        let moves = pos.allLegalMoves(for: .attacker)
        cache.store(position: pos, player: .attacker, moves: moves)
        var computed = false
        let result = cache.getOrCompute(position: pos, player: .attacker) {
            computed = true
            return pos.allLegalMoves(for: .attacker)
        }
        #expect(!computed)
        #expect(result.count == moves.count)
    }

    @Test("getOrCompute computes on miss")
    func getOrComputeMiss() {
        var cache = LegalMoveCache()
        let pos = Position.copenhagenStart()
        var computed = false
        let result = cache.getOrCompute(position: pos, player: .attacker) {
            computed = true
            return pos.allLegalMoves(for: .attacker)
        }
        #expect(computed)
        #expect(!result.isEmpty)
    }
}
