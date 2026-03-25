import Testing
@testable import Hnefatafl

@Suite("Sound Settings Tests")
struct SoundSettingsTests {

    @Test("default volume is 0.8")
    func defaultVolume() {
        let settings = SoundSettings()
        #expect(settings.volume == 0.8)
    }

    @Test("default enabled is true")
    func defaultEnabled() {
        let settings = SoundSettings()
        #expect(settings.enabled)
    }

    @Test("mute sets volume to 0")
    func mute() {
        let settings = SoundSettings().mute()
        #expect(!settings.enabled)
    }

    @Test("unmute restores enabled")
    func unmute() {
        let settings = SoundSettings().mute().unmute()
        #expect(settings.enabled)
    }

    @Test("set volume clamps to range")
    func clampVolume() {
        let low = SoundSettings().withVolume(-0.5)
        let high = SoundSettings().withVolume(2.0)
        #expect(low.volume == 0.0)
        #expect(high.volume == 1.0)
    }

    @Test("effective volume is zero when disabled")
    func effectiveVolumeDisabled() {
        let settings = SoundSettings().mute()
        #expect(settings.effectiveVolume == 0)
    }

    @Test("effective volume equals volume when enabled")
    func effectiveVolumeEnabled() {
        let settings = SoundSettings()
        #expect(settings.effectiveVolume == settings.volume)
    }

    @Test("SoundSettings is Equatable")
    func equatable() {
        let a = SoundSettings()
        let b = SoundSettings()
        #expect(a == b)
    }
}
