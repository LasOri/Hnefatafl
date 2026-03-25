import Testing
@testable import Hnefatafl

@Suite("Theme Colors Tests")
struct ThemeColorsTests {

    @Test("three themes available")
    func threeThemes() {
        #expect(ThemeColors.allThemes.count == 3)
    }

    @Test("classic theme has correct name")
    func classicHasName() {
        #expect(ThemeColors.classic.name == "Classic")
    }

    @Test("dark colors differ from classic")
    func darkDiffersFromClassic() {
        #expect(ThemeColors.dark.lightSquare != ThemeColors.classic.lightSquare)
        #expect(ThemeColors.dark.darkSquare != ThemeColors.classic.darkSquare)
    }

    @Test("nordic theme exists")
    func nordicExists() {
        #expect(ThemeColors.nordic.name == "Nordic")
        #expect(ThemeColors.allThemes.contains(ThemeColors.nordic))
    }

    @Test("all themes have hex color format")
    func allThemesHaveHexColors() {
        for theme in ThemeColors.allThemes {
            #expect(theme.lightSquare.hasPrefix("#"))
            #expect(theme.darkSquare.hasPrefix("#"))
            #expect(theme.selectedSquare.hasPrefix("#"))
            #expect(theme.legalMoveIndicator.hasPrefix("#"))
            #expect(theme.lightSquare.count == 7 || theme.lightSquare.count == 9)
            #expect(theme.darkSquare.count == 7 || theme.darkSquare.count == 9)
        }
    }
}
