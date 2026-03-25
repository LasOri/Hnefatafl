import Testing
@testable import Hnefatafl

@Suite("ThemeRegistry Tests")
struct ThemeRegistryTests {

    @Test("default themes are available")
    func defaultThemes() {
        let themes = ThemeRegistry.allThemes
        #expect(themes.count >= 4)
    }

    @Test("viking theme exists")
    func vikingTheme() {
        let theme = ThemeRegistry.theme(named: "Viking")
        #expect(theme != nil)
        #expect(theme?.name == "Viking")
    }

    @Test("classic theme exists")
    func classicTheme() {
        let theme = ThemeRegistry.theme(named: "Classic")
        #expect(theme != nil)
    }

    @Test("modern theme exists")
    func modernTheme() {
        let theme = ThemeRegistry.theme(named: "Modern")
        #expect(theme != nil)
    }

    @Test("high contrast theme exists")
    func highContrastTheme() {
        let theme = ThemeRegistry.theme(named: "High Contrast")
        #expect(theme != nil)
    }

    @Test("unknown theme returns nil")
    func unknownTheme() {
        let theme = ThemeRegistry.theme(named: "Nonexistent")
        #expect(theme == nil)
    }

    @Test("theme has required color properties")
    func themeProperties() {
        let theme = ThemeRegistry.theme(named: "Viking")!
        #expect(!theme.lightSquare.isEmpty)
        #expect(!theme.darkSquare.isEmpty)
        #expect(!theme.attackerColor.isEmpty)
        #expect(!theme.defenderColor.isEmpty)
        #expect(!theme.kingColor.isEmpty)
        #expect(!theme.backgroundColor.isEmpty)
    }

    @Test("ThemePreset is Equatable")
    func themeEquatable() {
        let a = ThemeRegistry.theme(named: "Viking")!
        let b = ThemeRegistry.theme(named: "Viking")!
        #expect(a == b)
    }

    @Test("all themes have unique names")
    func uniqueNames() {
        let names = ThemeRegistry.allThemes.map(\.name)
        let unique = Set(names)
        #expect(names.count == unique.count)
    }

    @Test("default theme is Viking")
    func defaultTheme() {
        #expect(ThemeRegistry.defaultTheme.name == "Viking")
    }
}
