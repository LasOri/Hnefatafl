import Testing
@testable import Hnefatafl

@Suite("BestReply Tests")
struct BestReplyTests {

    @Test("finds a move from start position")
    func findsMove() {
        let position = Position.copenhagenStart()
        let result = BestReply.find(position: position, player: .attacker)
        #expect(result.move != nil)
    }

    @Test("no moves returns nil move and zero score")
    func noMoves() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let result = BestReply.find(position: position, player: .attacker)
        #expect(result.move == nil)
        #expect(result.score == 0)
    }

    @Test("defender finds a move from start")
    func defenderFindsMove() {
        let position = Position.copenhagenStart()
        let result = BestReply.find(position: position, player: .defender)
        #expect(result.move != nil)
    }

    @Test("result has a score")
    func resultHasScore() {
        let position = Position.copenhagenStart()
        let result = BestReply.find(position: position, player: .attacker)
        #expect(result.score != 0)
    }

    @Test("BestReplyResult is Equatable")
    func equatable() {
        let a = BestReplyResult(move: nil, score: 0)
        let b = BestReplyResult(move: nil, score: 0)
        #expect(a == b)
    }
}
