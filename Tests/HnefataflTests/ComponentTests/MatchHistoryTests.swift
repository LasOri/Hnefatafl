import Testing
@testable import Hnefatafl

@Suite("MatchHistory Tests")
struct MatchHistoryTests {

    @Test("empty history")
    func emptyHistory() {
        let history = MatchHistory()
        #expect(history.totalGames == 0)
        #expect(history.attackerWins == 0)
        #expect(history.defenderWins == 0)
        #expect(history.draws == 0)
    }

    @Test("record a game")
    func recordGame() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 30)
        #expect(history.totalGames == 1)
    }

    @Test("attacker and defender win counts")
    func winCounts() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 20)
        history.record(winner: .defender, moveCount: 25)
        #expect(history.attackerWins == 1)
        #expect(history.defenderWins == 1)
    }

    @Test("draws counted")
    func drawsCounted() {
        var history = MatchHistory()
        history.record(winner: nil, moveCount: 100)
        #expect(history.draws == 1)
    }

    @Test("average move count")
    func averageMoveCount() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 20)
        history.record(winner: .defender, moveCount: 40)
        #expect(history.averageMoveCount == 30.0)
    }

    @Test("multiple games tracked")
    func multipleGames() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 10)
        history.record(winner: .attacker, moveCount: 20)
        history.record(winner: .defender, moveCount: 30)
        history.record(winner: nil, moveCount: 50)
        #expect(history.totalGames == 4)
        #expect(history.attackerWins == 2)
        #expect(history.defenderWins == 1)
        #expect(history.draws == 1)
    }
}
