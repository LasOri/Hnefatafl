import Testing
@testable import Hnefatafl

@Suite("LazyMoveGen Tests")
struct LazyMoveGenTests {

    @Test("hasNext on start position")
    func hasNextOnStart() {
        let position = Position.copenhagenStart()
        let gen = LazyMoveGen(position: position, player: .attacker)
        #expect(gen.hasNext)
    }

    @Test("next returns a move")
    func nextReturnsMove() {
        let position = Position.copenhagenStart()
        var gen = LazyMoveGen(position: position, player: .attacker)
        let move = gen.next()
        #expect(move != nil)
    }

    @Test("exhaustion returns nil")
    func exhaustionReturnsNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        var gen = LazyMoveGen(position: position, player: .attacker)
        #expect(!gen.hasNext)
        #expect(gen.next() == nil)
    }

    @Test("count matches allLegalMoves")
    func countMatchesAll() {
        let position = Position.copenhagenStart()
        let gen = LazyMoveGen(position: position, player: .attacker)
        let allMoves = position.allLegalMoves(for: .attacker)
        #expect(gen.count == allMoves.count)
    }

    @Test("reset resets index")
    func resetResetsIndex() {
        let position = Position.copenhagenStart()
        var gen = LazyMoveGen(position: position, player: .attacker)
        _ = gen.next()
        _ = gen.next()
        #expect(gen.generated == 2)
        gen.reset()
        #expect(gen.generated == 0)
        #expect(gen.hasNext)
    }

    @Test("generated tracks progress")
    func generatedTracksProgress() {
        let position = Position.copenhagenStart()
        var gen = LazyMoveGen(position: position, player: .attacker)
        #expect(gen.generated == 0)
        _ = gen.next()
        #expect(gen.generated == 1)
        _ = gen.next()
        #expect(gen.generated == 2)
    }
}
