import Testing
@testable import Hnefatafl

@Suite("Game Clock Display Tests")
struct GameClockDisplayTests {

    @Test("format seconds as mm:ss")
    func formatSeconds() {
        #expect(GameClockDisplay.format(seconds: 125) == "2:05")
    }

    @Test("format zero")
    func formatZero() {
        #expect(GameClockDisplay.format(seconds: 0) == "0:00")
    }

    @Test("format hours")
    func formatHours() {
        #expect(GameClockDisplay.format(seconds: 3661) == "1:01:01")
    }

    @Test("low time warning threshold")
    func lowTimeWarning() {
        #expect(GameClockDisplay.isLowTime(seconds: 30, threshold: 60))
        #expect(!GameClockDisplay.isLowTime(seconds: 120, threshold: 60))
    }

    @Test("progress percentage")
    func progress() {
        let pct = GameClockDisplay.progress(remaining: 150, total: 300)
        #expect(pct == 50.0)
    }

    @Test("progress clamped to 0-100")
    func progressClamped() {
        #expect(GameClockDisplay.progress(remaining: -10, total: 300) == 0)
        #expect(GameClockDisplay.progress(remaining: 400, total: 300) == 100)
    }

    @Test("color for remaining time")
    func colorForTime() {
        let normal = GameClockDisplay.color(remaining: 200, total: 300)
        let low = GameClockDisplay.color(remaining: 10, total: 300)
        #expect(normal != low)
    }

    @Test("format with padding")
    func formatPadding() {
        let result = GameClockDisplay.format(seconds: 5)
        #expect(result == "0:05")
    }
}
