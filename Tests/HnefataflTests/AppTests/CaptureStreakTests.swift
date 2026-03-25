import Testing
@testable import Hnefatafl

@Suite("Capture Streak Tests")
struct CaptureStreakTests {

    @Test("empty history has no streak")
    func emptyHistory() {
        let streak = CaptureStreak.current(history: [])
        #expect(streak == 0)
    }

    @Test("single capture streak of 1")
    func singleCapture() {
        let streak = CaptureStreak.current(history: [true])
        #expect(streak == 1)
    }

    @Test("streak counts consecutive captures from end")
    func consecutiveFromEnd() {
        let streak = CaptureStreak.current(history: [false, true, true, true])
        #expect(streak == 3)
    }

    @Test("no captures returns zero")
    func noCaptures() {
        let streak = CaptureStreak.current(history: [false, false, false])
        #expect(streak == 0)
    }

    @Test("broken streak resets")
    func brokenStreak() {
        let streak = CaptureStreak.current(history: [true, true, false, true])
        #expect(streak == 1)
    }

    @Test("longest streak finds max")
    func longestStreak() {
        let longest = CaptureStreak.longest(history: [true, true, false, true, true, true])
        #expect(longest == 3)
    }

    @Test("longest streak empty")
    func longestEmpty() {
        let longest = CaptureStreak.longest(history: [])
        #expect(longest == 0)
    }

    @Test("total captures counts all trues")
    func totalCaptures() {
        let total = CaptureStreak.totalCaptures(history: [true, false, true, true, false])
        #expect(total == 3)
    }
}
