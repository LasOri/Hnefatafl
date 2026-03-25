import Testing
@testable import Hnefatafl

@Suite("Animation Config Tests")
struct AnimationConfigTests {

    @Test("standard settings values")
    func standardSettings() {
        let s = AnimationSettings.standard
        #expect(s.moveSpeed == 0.3)
        #expect(s.captureDelay == 0.15)
        #expect(s.highlightDuration == 0.5)
    }

    @Test("fast settings are faster than standard")
    func fastSettings() {
        let fast = AnimationSettings.fast
        let standard = AnimationSettings.standard
        #expect(fast.moveSpeed < standard.moveSpeed)
        #expect(fast.captureDelay < standard.captureDelay)
        #expect(fast.highlightDuration < standard.highlightDuration)
    }

    @Test("none settings are zero")
    func noneSettings() {
        let n = AnimationSettings.none
        #expect(n.moveSpeed == 0)
        #expect(n.captureDelay == 0)
        #expect(n.highlightDuration == 0)
    }

    @Test("settings are equatable")
    func equatable() {
        let a = AnimationSettings.standard
        let b = AnimationSettings(moveSpeed: 0.3, captureDelay: 0.15, highlightDuration: 0.5)
        #expect(a == b)
    }

    @Test("custom settings are mutable")
    func mutable() {
        var s = AnimationSettings.standard
        s.moveSpeed = 1.0
        #expect(s.moveSpeed == 1.0)
        #expect(s != AnimationSettings.standard)
    }
}
