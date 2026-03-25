import Testing
@testable import Hnefatafl

@Suite("Sound Theme Tests")
struct SoundThemeTests {

    @Test("classic theme has name Classic")
    func classicName() {
        #expect(SoundTheme.classic.name == "Classic")
    }

    @Test("minimal theme has volume 0.5")
    func minimalVolume() {
        #expect(SoundTheme.minimal.volume == 0.5)
    }

    @Test("silent theme has empty sounds")
    func silentSounds() {
        #expect(SoundTheme.silent.moveSound == "")
        #expect(SoundTheme.silent.captureSound == "")
        #expect(SoundTheme.silent.winSound == "")
    }

    @Test("all themes has three entries")
    func allThemesCount() {
        #expect(SoundTheme.allThemes.count == 3)
    }

    @Test("SoundThemeConfig supports equality")
    func configEquality() {
        let a = SoundThemeConfig(name: "X", moveSound: "a", captureSound: "b", winSound: "c", volume: 1.0)
        let b = SoundThemeConfig(name: "X", moveSound: "a", captureSound: "b", winSound: "c", volume: 1.0)
        #expect(a == b)
    }
}
