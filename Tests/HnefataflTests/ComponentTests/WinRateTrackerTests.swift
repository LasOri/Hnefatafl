import Testing
@testable import Hnefatafl

@Suite("WinRateTracker Tests")
struct WinRateTrackerTests {

    @Test("initial rates are zero")
    func initialRatesZero() {
        let tracker = WinRateTracker()
        #expect(tracker.attackerRate.wins == 0)
        #expect(tracker.attackerRate.losses == 0)
        #expect(tracker.attackerRate.draws == 0)
        #expect(tracker.defenderRate.wins == 0)
        #expect(tracker.defenderRate.losses == 0)
        #expect(tracker.defenderRate.draws == 0)
    }

    @Test("attacker win recorded")
    func attackerWinRecorded() {
        var tracker = WinRateTracker()
        tracker.recordResult(winner: .attacker)
        #expect(tracker.attackerRate.wins == 1)
        #expect(tracker.defenderRate.losses == 1)
    }

    @Test("defender win recorded")
    func defenderWinRecorded() {
        var tracker = WinRateTracker()
        tracker.recordResult(winner: .defender)
        #expect(tracker.defenderRate.wins == 1)
        #expect(tracker.attackerRate.losses == 1)
    }

    @Test("draw recorded")
    func drawRecorded() {
        var tracker = WinRateTracker()
        tracker.recordResult(winner: nil)
        #expect(tracker.attackerRate.draws == 1)
        #expect(tracker.defenderRate.draws == 1)
    }

    @Test("win percentage calculated")
    func winPercentageCalculated() {
        var tracker = WinRateTracker()
        tracker.recordResult(winner: .attacker)
        tracker.recordResult(winner: .attacker)
        tracker.recordResult(winner: .defender)
        tracker.recordResult(winner: nil)
        #expect(tracker.attackerRate.winPercentage == 50.0)
    }

    @Test("total matches count")
    func totalMatchesCount() {
        var tracker = WinRateTracker()
        tracker.recordResult(winner: .attacker)
        tracker.recordResult(winner: .defender)
        tracker.recordResult(winner: nil)
        #expect(tracker.attackerRate.total == 3)
        #expect(tracker.defenderRate.total == 3)
    }
}
