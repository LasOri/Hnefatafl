import Testing
@testable import Hnefatafl

@Suite("Theme CSS Tests")
struct ThemeCSSTests {

    @Test("classic theme has board bg")
    func classicBoardBg() {
        let css = BoardTheme.classic.cssVariables
        #expect(css.contains("--board-bg"))
    }

    @Test("all themes have square bg")
    func allSquareBg() {
        for theme in BoardTheme.allCases {
            #expect(theme.cssVariables.contains("--square-bg"))
        }
    }

    @Test("ThemeCSS generates root block")
    func rootBlock() {
        let css = ThemeCSS.generate(theme: .classic)
        #expect(css.contains(":root"))
    }

    @Test("ThemeCSS includes accent color")
    func accentColor() {
        let css = ThemeCSS.generate(theme: .darkWood)
        #expect(css.contains("--accent-color"))
    }

    @Test("ThemeCSS includes light and dark square")
    func squareColors() {
        let css = ThemeCSS.generate(theme: .marble)
        #expect(css.contains("--light-square"))
        #expect(css.contains("--dark-square"))
    }

    @Test("each theme generates different CSS")
    func differentCSS() {
        let classic = ThemeCSS.generate(theme: .classic)
        let ice = ThemeCSS.generate(theme: .ice)
        #expect(classic != ice)
    }

    @Test("ThemeCSS includes highlight color")
    func highlightColor() {
        let css = ThemeCSS.generate(theme: .classic)
        #expect(css.contains("--highlight-color"))
    }

    @Test("theme CSS is non-empty")
    func nonEmpty() {
        for theme in BoardTheme.allCases {
            #expect(!ThemeCSS.generate(theme: theme).isEmpty)
        }
    }
}
