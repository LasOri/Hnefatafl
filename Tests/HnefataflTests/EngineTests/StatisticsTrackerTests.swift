import Testing
@testable import Hnefatafl

@Suite("StatisticsTracker Tests")
struct StatisticsTrackerTests {

    @Test("initial tracker has zero stats")
    func initialZero() {
        let tracker = StatisticsTracker()
        #expect(tracker.gamesPlayed == 0)
        #expect(tracker.gamesWon == 0)
        #expect(tracker.gamesLost == 0)
        #expect(tracker.gamesDraw == 0)
    }

    @Test("record attacker win")
    func recordAttackerWin() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 20)
        #expect(tracker.gamesPlayed == 1)
        #expect(tracker.gamesWon == 1)
    }

    @Test("record defender loss")
    func recordDefenderLoss() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .defender, moveCount: 20)
        #expect(tracker.gamesLost == 1)
    }

    @Test("record draw")
    func recordDraw() {
        var tracker = StatisticsTracker()
        tracker.record(result: .draw, playedAs: .attacker, moveCount: 50)
        #expect(tracker.gamesDraw == 1)
    }

    @Test("win rate computes correctly")
    func winRate() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 20)
        tracker.record(result: .defenderWins, playedAs: .attacker, moveCount: 30)
        #expect(tracker.winRate == 0.5)
    }

    @Test("win rate is zero when no games played")
    func winRateZero() {
        let tracker = StatisticsTracker()
        #expect(tracker.winRate == 0.0)
    }

    @Test("average move count")
    func averageMoveCount() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 10)
        tracker.record(result: .defenderWins, playedAs: .defender, moveCount: 30)
        #expect(tracker.averageMoveCount == 20.0)
    }

    @Test("longest game tracked")
    func longestGame() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 10)
        tracker.record(result: .defenderWins, playedAs: .defender, moveCount: 50)
        tracker.record(result: .draw, playedAs: .attacker, moveCount: 30)
        #expect(tracker.longestGame == 50)
    }

    @Test("shortest game tracked")
    func shortestGame() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 10)
        tracker.record(result: .defenderWins, playedAs: .defender, moveCount: 50)
        #expect(tracker.shortestGame == 10)
    }

    @Test("StatisticsTracker is Equatable")
    func equatable() {
        let a = StatisticsTracker()
        let b = StatisticsTracker()
        #expect(a == b)
    }

    @Test("current streak increments on wins")
    func winStreak() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 10)
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 15)
        #expect(tracker.currentWinStreak == 2)
    }

    @Test("win streak resets on loss")
    func streakResets() {
        var tracker = StatisticsTracker()
        tracker.record(result: .attackerWins, playedAs: .attacker, moveCount: 10)
        tracker.record(result: .defenderWins, playedAs: .attacker, moveCount: 20)
        #expect(tracker.currentWinStreak == 0)
    }
}
