import Testing
@testable import Hnefatafl

@Suite("Board Theme Config Tests")
struct BoardThemeConfigTests {

    @Test("default theme has expected name")
    func defaultThemeName() {
        #expect(BoardThemeConfig.defaultTheme.name == "Classic")
    }

    @Test("default theme shows coordinates")
    func defaultShowsCoords() {
        #expect(BoardThemeConfig.defaultTheme.showCoords == true)
    }

    @Test("compact theme has smaller cell size")
    func compactCellSize() {
        #expect(BoardThemeConfig.compactTheme.cellSize < BoardThemeConfig.defaultTheme.cellSize)
    }

    @Test("compact theme hides coordinates")
    func compactHidesCoords() {
        #expect(BoardThemeConfig.compactTheme.showCoords == false)
    }

    @Test("equatable compares all fields")
    func equatable() {
        let a = BoardThemeConfig.defaultTheme
        let b = BoardThemeConfig.defaultTheme
        #expect(a == b)
    }

    @Test("different themes are not equal")
    func notEqual() {
        #expect(BoardThemeConfig.defaultTheme != BoardThemeConfig.compactTheme)
    }

    @Test("custom theme can be created")
    func customTheme() {
        let custom = BoardThemeConfig(
            name: "Dark",
            cellSize: 40,
            showCoords: true,
            darkSquare: "#333333",
            lightSquare: "#666666"
        )
        #expect(custom.name == "Dark")
        #expect(custom.cellSize == 40)
    }
}
