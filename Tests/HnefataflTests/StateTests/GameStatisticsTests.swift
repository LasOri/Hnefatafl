import Testing
@testable import Hnefatafl

@Suite("Game Statistics Tests")
struct GameStatisticsTests {

    @Test("empty stats have zero wins and losses")
    func emptyStats() {
        let stats = GameStatistics()
        #expect(stats.attackerWins == 0)
        #expect(stats.defenderWins == 0)
        #expect(stats.draws == 0)
        #expect(stats.totalGames == 0)
    }

    @Test("recording attacker win increments count")
    func recordAttackerWin() {
        var stats = GameStatistics()
        stats = stats.record(result: .attackerWins, moveCount: 20)
        #expect(stats.attackerWins == 1)
        #expect(stats.totalGames == 1)
    }

    @Test("recording defender win increments count")
    func recordDefenderWin() {
        var stats = GameStatistics()
        stats = stats.record(result: .defenderWins, moveCount: 15)
        #expect(stats.defenderWins == 1)
    }

    @Test("recording draw increments count")
    func recordDraw() {
        var stats = GameStatistics()
        stats = stats.record(result: .draw, moveCount: 200)
        #expect(stats.draws == 1)
    }

    @Test("averageMoveCount computes correctly")
    func averageMoves() {
        var stats = GameStatistics()
        stats = stats.record(result: .attackerWins, moveCount: 10)
        stats = stats.record(result: .defenderWins, moveCount: 30)
        #expect(stats.averageMoveCount == 20)
    }

    @Test("averageMoveCount is zero when no games")
    func averageZero() {
        let stats = GameStatistics()
        #expect(stats.averageMoveCount == 0)
    }

    @Test("longestGame tracks maximum")
    func longestGame() {
        var stats = GameStatistics()
        stats = stats.record(result: .attackerWins, moveCount: 10)
        stats = stats.record(result: .defenderWins, moveCount: 50)
        stats = stats.record(result: .attackerWins, moveCount: 30)
        #expect(stats.longestGame == 50)
    }

    @Test("shortestGame tracks minimum")
    func shortestGame() {
        var stats = GameStatistics()
        stats = stats.record(result: .attackerWins, moveCount: 10)
        stats = stats.record(result: .defenderWins, moveCount: 50)
        #expect(stats.shortestGame == 10)
    }
}
