import Testing
@testable import Hnefatafl

@Suite("Game Speed Setting Tests")
struct GameSpeedSettingTests {

    @Test("slow preset has longest animation duration")
    func slowLongestDuration() {
        #expect(GameSpeedSetting.slow.animationDuration > GameSpeedSetting.normal.animationDuration)
        #expect(GameSpeedSetting.slow.animationDuration > GameSpeedSetting.fast.animationDuration)
    }

    @Test("fast preset has shortest animation duration")
    func fastShortestDuration() {
        #expect(GameSpeedSetting.fast.animationDuration < GameSpeedSetting.normal.animationDuration)
    }

    @Test("slow preset has longest auto play delay")
    func slowLongestDelay() {
        #expect(GameSpeedSetting.slow.autoPlayDelay > GameSpeedSetting.normal.autoPlayDelay)
    }

    @Test("fast preset has shortest auto play delay")
    func fastShortestDelay() {
        #expect(GameSpeedSetting.fast.autoPlayDelay < GameSpeedSetting.normal.autoPlayDelay)
    }

    @Test("presets are equatable")
    func equatable() {
        let a = GameSpeedSetting.normal
        let b = GameSpeedSetting.normal
        #expect(a == b)
    }

    @Test("custom setting differs from presets")
    func customSetting() {
        let custom = GameSpeedSetting(animationDuration: 1.0, autoPlayDelay: 5.0)
        #expect(custom != GameSpeedSetting.slow)
        #expect(custom != GameSpeedSetting.normal)
        #expect(custom != GameSpeedSetting.fast)
    }

    @Test("all durations are positive")
    func positiveDurations() {
        #expect(GameSpeedSetting.slow.animationDuration > 0)
        #expect(GameSpeedSetting.normal.animationDuration > 0)
        #expect(GameSpeedSetting.fast.animationDuration > 0)
        #expect(GameSpeedSetting.slow.autoPlayDelay > 0)
        #expect(GameSpeedSetting.normal.autoPlayDelay > 0)
        #expect(GameSpeedSetting.fast.autoPlayDelay > 0)
    }
}
