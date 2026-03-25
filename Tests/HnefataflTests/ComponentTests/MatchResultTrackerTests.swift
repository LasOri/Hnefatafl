import Testing
@testable import Hnefatafl

@Suite("Match Result Tracker Tests")
struct MatchResultTrackerTests {

    @Test("initially empty")
    func initiallyEmpty() {
        let tracker = MatchResultTracker()
        #expect(tracker.results.isEmpty)
    }

    @Test("record adds result")
    func recordAdds() {
        var tracker = MatchResultTracker()
        tracker.record(MatchResult(winner: .attacker, moveCount: 30, duration: 120))
        #expect(tracker.results.count == 1)
    }

    @Test("attacker win count")
    func attackerWins() {
        var tracker = MatchResultTracker()
        tracker.record(MatchResult(winner: .attacker, moveCount: 30, duration: 120))
        tracker.record(MatchResult(winner: .defender, moveCount: 25, duration: 100))
        tracker.record(MatchResult(winner: .attacker, moveCount: 40, duration: 150))
        #expect(tracker.attackerWins == 2)
    }

    @Test("defender win count")
    func defenderWins() {
        var tracker = MatchResultTracker()
        tracker.record(MatchResult(winner: .defender, moveCount: 25, duration: 100))
        #expect(tracker.defenderWins == 1)
    }

    @Test("average move count")
    func averageMoves() {
        var tracker = MatchResultTracker()
        tracker.record(MatchResult(winner: .attacker, moveCount: 20, duration: 60))
        tracker.record(MatchResult(winner: .defender, moveCount: 40, duration: 120))
        #expect(tracker.averageMoveCount == 30)
    }

    @Test("MatchResult is Equatable")
    func equatable() {
        let a = MatchResult(winner: .attacker, moveCount: 30, duration: 120)
        let b = MatchResult(winner: .attacker, moveCount: 30, duration: 120)
        #expect(a == b)
    }

    @Test("draw count")
    func drawCount() {
        var tracker = MatchResultTracker()
        tracker.record(MatchResult(winner: nil, moveCount: 50, duration: 200))
        #expect(tracker.drawCount == 1)
    }
}
