import Testing
@testable import Hnefatafl

@Suite("BoardThemePreview Tests")
struct BoardThemePreviewTests {

    @Test("themes array has 3 presets")
    func threePresets() {
        #expect(BoardThemePreview.themes.count == 3)
    }

    @Test("Classic theme exists")
    func classicThemeExists() {
        let classic = BoardThemePreview.themes.first { $0.name == "Classic" }
        #expect(classic != nil)
    }

    @Test("Nordic theme exists")
    func nordicThemeExists() {
        let nordic = BoardThemePreview.themes.first { $0.name == "Nordic" }
        #expect(nordic != nil)
    }

    @Test("Midnight theme exists")
    func midnightThemeExists() {
        let midnight = BoardThemePreview.themes.first { $0.name == "Midnight" }
        #expect(midnight != nil)
    }

    @Test("all themes have non-empty colors")
    func allColorsNonEmpty() {
        for theme in BoardThemePreview.themes {
            #expect(!theme.lightColor.isEmpty)
            #expect(!theme.darkColor.isEmpty)
            #expect(!theme.accentColor.isEmpty)
        }
    }

    @Test("themes are equatable")
    func equatableConformance() {
        let a = BoardThemePreview(name: "Test", lightColor: "#FFF", darkColor: "#000", accentColor: "#F00")
        let b = BoardThemePreview(name: "Test", lightColor: "#FFF", darkColor: "#000", accentColor: "#F00")
        #expect(a == b)
    }
}
