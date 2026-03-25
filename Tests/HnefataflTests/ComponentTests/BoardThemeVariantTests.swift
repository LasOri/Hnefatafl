import Testing
@testable import Hnefatafl

@Suite("Board Theme Variant Tests")
struct BoardThemeVariantTests {

    @Test("all themes have names")
    func allHaveNames() {
        for theme in BoardThemeVariant.allCases {
            #expect(!theme.name.isEmpty)
        }
    }

    @Test("all themes have board colors")
    func allHaveBoardColors() {
        for theme in BoardThemeVariant.allCases {
            #expect(!theme.lightSquare.isEmpty)
            #expect(!theme.darkSquare.isEmpty)
        }
    }

    @Test("wood theme")
    func woodTheme() {
        let theme = BoardThemeVariant.wood
        #expect(theme.name == "Wood")
    }

    @Test("stone theme")
    func stoneTheme() {
        let theme = BoardThemeVariant.stone
        #expect(theme.name == "Stone")
    }

    @Test("ice theme")
    func iceTheme() {
        let theme = BoardThemeVariant.ice
        #expect(theme.name == "Ice")
    }

    @Test("next cycles through themes")
    func nextCycles() {
        var theme = BoardThemeVariant.wood
        let count = BoardThemeVariant.allCases.count
        for _ in 0..<count {
            theme = theme.next
        }
        #expect(theme == .wood)
    }

    @Test("CSS variables generated")
    func cssVariables() {
        let css = BoardThemeVariant.wood.cssVariables
        #expect(css.contains("--light-square"))
        #expect(css.contains("--dark-square"))
    }

    @Test("BoardThemeVariant is Equatable")
    func equatable() {
        #expect(BoardThemeVariant.wood == BoardThemeVariant.wood)
        #expect(BoardThemeVariant.wood != BoardThemeVariant.stone)
    }
}
