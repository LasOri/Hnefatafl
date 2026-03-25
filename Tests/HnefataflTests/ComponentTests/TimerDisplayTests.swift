import Testing
@testable import Hnefatafl

@Suite("Timer Display Tests")
struct TimerDisplayTests {

    @Test("format zero seconds")
    func formatZeroSeconds() {
        let data = TimerDisplay.format(totalSeconds: 0)
        #expect(data.minutes == 0)
        #expect(data.seconds == 0)
        #expect(data.formatted == "0:00")
    }

    @Test("format 90 seconds")
    func format90Seconds() {
        let data = TimerDisplay.format(totalSeconds: 90)
        #expect(data.minutes == 1)
        #expect(data.seconds == 30)
    }

    @Test("low threshold triggers when at or below")
    func lowThreshold() {
        let data = TimerDisplay.format(totalSeconds: 30)
        #expect(data.isLow)
    }

    @Test("not low above threshold")
    func notLowAboveThreshold() {
        let data = TimerDisplay.format(totalSeconds: 31)
        #expect(!data.isLow)
    }

    @Test("formatted string has correct format")
    func formattedString() {
        let data = TimerDisplay.format(totalSeconds: 125)
        #expect(data.formatted == "2:05")
    }
}
