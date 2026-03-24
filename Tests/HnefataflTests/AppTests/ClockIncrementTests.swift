import Testing
@testable import Hnefatafl

@Suite("Clock Increment Tests")
struct ClockIncrementTests {

    @Test("IncrementConfig stores seconds per move")
    func storesSeconds() {
        let config = IncrementConfig(secondsPerMove: 5)
        #expect(config.secondsPerMove == 5)
    }

    @Test("no increment is zero")
    func noIncrement() {
        #expect(IncrementConfig.none.secondsPerMove == 0)
    }

    @Test("Fischer increment preset")
    func fischerPreset() {
        let config = IncrementConfig.fischer
        #expect(config.secondsPerMove == 5)
    }

    @Test("Bronstein increment preset")
    func bronsteinPreset() {
        let config = IncrementConfig.bronstein
        #expect(config.secondsPerMove == 10)
    }

    @Test("apply increment adds time")
    func applyIncrement() {
        let config = IncrementConfig(secondsPerMove: 5)
        let newTime = config.apply(to: 100)
        #expect(newTime == 105)
    }

    @Test("no increment does not add time")
    func noIncrementNoAdd() {
        let config = IncrementConfig.none
        let newTime = config.apply(to: 100)
        #expect(newTime == 100)
    }

    @Test("IncrementConfig is Equatable")
    func equatable() {
        let a = IncrementConfig(secondsPerMove: 3)
        let b = IncrementConfig(secondsPerMove: 3)
        #expect(a == b)
    }

    @Test("label includes seconds")
    func label() {
        let config = IncrementConfig(secondsPerMove: 5)
        #expect(config.label.contains("5"))
    }

    @Test("none label")
    func noneLabel() {
        #expect(IncrementConfig.none.label == "No increment")
    }

    @Test("increment does not overflow")
    func noOverflow() {
        let config = IncrementConfig(secondsPerMove: 10)
        let newTime = config.apply(to: Int.max - 5)
        #expect(newTime >= 0)
    }
}
