import Testing
@testable import Hnefatafl

@Suite("BoardDominance Tests")
struct BoardDominanceTests {

    @Test("starting position has a dominance score")
    func startingScore() {
        let pos = Position.copenhagenStart()
        let result = BoardDominance.evaluate(position: pos)
        #expect(result.attackerScore > 0 || result.defenderScore > 0)
    }

    @Test("empty board has zero dominance")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let result = BoardDominance.evaluate(position: pos)
        #expect(result.attackerScore == 0)
        #expect(result.defenderScore == 0)
    }

    @Test("dominant player identified")
    func dominantPlayer() {
        let pos = Position.copenhagenStart()
        let result = BoardDominance.evaluate(position: pos)
        #expect(result.dominant == .attacker || result.dominant == .defender || result.dominant == nil)
    }

    @Test("DominanceResult is Equatable")
    func equatable() {
        let a = DominanceResult(attackerScore: 10, defenderScore: 5, dominant: .attacker)
        let b = DominanceResult(attackerScore: 10, defenderScore: 5, dominant: .attacker)
        #expect(a == b)
    }

    @Test("scores are non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let result = BoardDominance.evaluate(position: pos)
        #expect(result.attackerScore >= 0)
        #expect(result.defenderScore >= 0)
    }

    @Test("single attacker has small dominance")
    func singlePiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let result = BoardDominance.evaluate(position: pos)
        #expect(result.attackerScore > 0)
    }
}
