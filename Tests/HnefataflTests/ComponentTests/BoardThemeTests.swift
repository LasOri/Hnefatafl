import Testing
@testable import Hnefatafl

@Suite("Board Theme Tests")
struct BoardThemeTests {

    @Test("BoardTheme has four themes")
    func hasThemes() {
        #expect(BoardTheme.allCases.count == 4)
    }

    @Test("each theme has a label")
    func hasLabels() {
        for theme in BoardTheme.allCases {
            #expect(!theme.label.isEmpty)
        }
    }

    @Test("each theme has CSS variables")
    func hasCSSVars() {
        for theme in BoardTheme.allCases {
            let vars = theme.cssVariables
            #expect(vars.contains("--board-bg"))
            #expect(vars.contains("--square-bg"))
        }
    }

    @Test("classic theme is default")
    func classicDefault() {
        #expect(BoardTheme.classic == BoardTheme.allCases.first)
    }

    @Test("next cycles through themes")
    func cyclesThemes() {
        let start = BoardTheme.classic
        let second = start.next
        #expect(second != start)
        var current = start
        for _ in 0..<4 {
            current = current.next
        }
        #expect(current == start)
    }

    @Test("dark wood theme has darker colors")
    func darkWoodColors() {
        let vars = BoardTheme.darkWood.cssVariables
        #expect(vars.contains("--board-bg"))
    }

    @Test("marble theme has light colors")
    func marbleColors() {
        let vars = BoardTheme.marble.cssVariables
        #expect(vars.contains("--square-bg"))
    }

    @Test("ice theme has blue tones")
    func iceColors() {
        let vars = BoardTheme.ice.cssVariables
        #expect(vars.contains("#"))
    }
}
