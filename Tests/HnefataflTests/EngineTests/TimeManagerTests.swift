import Testing
@testable import Hnefatafl

@Suite("TimeManager Tests")
struct TimeManagerTests {

    @Test("allocate returns positive times")
    func allocatePositiveTimes() {
        let allocation = TimeManager.allocate(totalTime: 300, movesPlayed: 0, estimatedMovesLeft: 50)
        #expect(allocation.baseTime > 0)
        #expect(allocation.maxTime > 0)
        #expect(allocation.emergencyTime > 0)
    }

    @Test("more time allocated early in game")
    func moreTimeEarlyGame() {
        let early = TimeManager.allocate(totalTime: 300, movesPlayed: 0, estimatedMovesLeft: 50)
        let late = TimeManager.allocate(totalTime: 300, movesPlayed: 40, estimatedMovesLeft: 10)
        #expect(late.baseTime > early.baseTime)
    }

    @Test("less time allocated late in game with less total")
    func lessTimeLateGame() {
        let early = TimeManager.allocate(totalTime: 300, movesPlayed: 0, estimatedMovesLeft: 50)
        let late = TimeManager.allocate(totalTime: 100, movesPlayed: 40, estimatedMovesLeft: 50)
        #expect(late.baseTime < early.baseTime)
    }

    @Test("should stop when time exceeded")
    func shouldStopWhenExceeded() {
        let allocation = TimeAllocation(baseTime: 5, maxTime: 10, emergencyTime: 0.5)
        #expect(TimeManager.shouldStopSearch(elapsed: 11, allocation: allocation))
        #expect(!TimeManager.shouldStopSearch(elapsed: 5, allocation: allocation))
    }

    @Test("estimate moves from position")
    func estimateMovesFromPosition() {
        let position = Position.copenhagenStart()
        let estimate = TimeManager.estimateMovesRemaining(position: position)
        #expect(estimate >= 10)
        #expect(estimate > 0)
    }

    @Test("emergency time is positive")
    func emergencyTimePositive() {
        let allocation = TimeManager.allocate(totalTime: 300, movesPlayed: 0, estimatedMovesLeft: 50)
        #expect(allocation.emergencyTime > 0)
    }
}
