import Testing
@testable import Hnefatafl

@Suite("Sound Effect Config Tests")
struct SoundEffectConfigTests {

    @Test("default config is enabled")
    func defaultEnabled() {
        #expect(SoundEffectConfig.defaultConfig.enabled == true)
    }

    @Test("default config has positive volume")
    func defaultPositiveVolume() {
        #expect(SoundEffectConfig.defaultConfig.volume > 0)
    }

    @Test("muted preset is disabled")
    func mutedDisabled() {
        #expect(SoundEffectConfig.muted.enabled == false)
    }

    @Test("muted preset has zero volume")
    func mutedZeroVolume() {
        #expect(SoundEffectConfig.muted.volume == 0)
    }

    @Test("default config has move sound")
    func defaultMoveSound() {
        #expect(SoundEffectConfig.defaultConfig.moveSound == "move")
    }

    @Test("default config has capture sound")
    func defaultCaptureSound() {
        #expect(SoundEffectConfig.defaultConfig.captureSound == "capture")
    }

    @Test("presets are equatable")
    func equatable() {
        let a = SoundEffectConfig.defaultConfig
        let b = SoundEffectConfig.defaultConfig
        #expect(a == b)
        #expect(SoundEffectConfig.defaultConfig != SoundEffectConfig.muted)
    }
}
