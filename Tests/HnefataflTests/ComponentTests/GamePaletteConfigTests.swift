import Testing
@testable import Hnefatafl

@Suite("GamePaletteConfig Tests")
struct GamePaletteConfigTests {

    @Test("light preset has correct primary color")
    func lightPrimary() {
        #expect(GamePaletteConfig.light.primary == "#333333")
    }

    @Test("dark preset has correct background")
    func darkBackground() {
        #expect(GamePaletteConfig.dark.background == "#1C1C1E")
    }

    @Test("light preset has white background")
    func lightBackground() {
        #expect(GamePaletteConfig.light.background == "#FFFFFF")
    }

    @Test("dark preset has correct accent")
    func darkAccent() {
        #expect(GamePaletteConfig.dark.accent == "#0A84FF")
    }

    @Test("light and dark presets are different")
    func presetsAreDifferent() {
        #expect(GamePaletteConfig.light != GamePaletteConfig.dark)
    }

    @Test("GamePaletteConfig conforms to Equatable")
    func equatableConformance() {
        let a = GamePaletteConfig(primary: "#000", secondary: "#111", accent: "#222", background: "#333")
        let b = GamePaletteConfig(primary: "#000", secondary: "#111", accent: "#222", background: "#333")
        #expect(a == b)
    }

    @Test("light preset secondary color is set")
    func lightSecondary() {
        #expect(GamePaletteConfig.light.secondary == "#666666")
    }
}
