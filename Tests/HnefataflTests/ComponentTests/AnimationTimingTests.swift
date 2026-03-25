import Testing
@testable import Hnefatafl

@Suite("Animation Timing Tests")
struct AnimationTimingTests {

    @Test("fast preset has shortest duration")
    func fastShortest() {
        #expect(AnimationTiming.fast.duration < AnimationTiming.normal.duration)
        #expect(AnimationTiming.fast.duration < AnimationTiming.slow.duration)
    }

    @Test("slow preset has longest duration")
    func slowLongest() {
        #expect(AnimationTiming.slow.duration > AnimationTiming.normal.duration)
    }

    @Test("total duration sums delay and duration")
    func totalDurationComputed() {
        let timing = AnimationTiming.slow
        #expect(timing.totalDuration == timing.duration + timing.delay)
    }

    @Test("fast has zero delay")
    func fastZeroDelay() {
        #expect(AnimationTiming.fast.delay == 0.0)
    }

    @Test("timings are equatable")
    func equatable() {
        let a = AnimationTiming.normal
        let b = AnimationTiming(duration: 0.3, delay: 0.0, easing: "ease-in-out")
        #expect(a == b)
    }

    @Test("easing strings are set correctly")
    func easingStrings() {
        #expect(AnimationTiming.fast.easing == "ease-out")
        #expect(AnimationTiming.normal.easing == "ease-in-out")
        #expect(AnimationTiming.slow.easing == "ease-in-out")
    }

    @Test("custom timing differs from presets")
    func customDiffers() {
        let custom = AnimationTiming(duration: 1.0, delay: 0.5, easing: "linear")
        #expect(custom != AnimationTiming.fast)
        #expect(custom != AnimationTiming.normal)
        #expect(custom != AnimationTiming.slow)
        #expect(custom.totalDuration == 1.5)
    }
}
