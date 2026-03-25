import Testing
@testable import Hnefatafl

@Suite("Game Sidebar Tests")
struct GameSidebarTests {

    @Test("collapsed preset is not visible")
    func collapsedNotVisible() {
        #expect(GameSidebar.collapsed.isVisible == false)
    }

    @Test("collapsed preset has zero width")
    func collapsedZeroWidth() {
        #expect(GameSidebar.collapsed.width == 0)
    }

    @Test("expanded preset is visible")
    func expandedVisible() {
        #expect(GameSidebar.expanded.isVisible == true)
    }

    @Test("expanded preset has positive width")
    func expandedPositiveWidth() {
        #expect(GameSidebar.expanded.width > 0)
    }

    @Test("expanded shows analysis and history")
    func expandedShowsAll() {
        #expect(GameSidebar.expanded.showAnalysis == true)
        #expect(GameSidebar.expanded.showHistory == true)
    }

    @Test("presets are equatable")
    func equatable() {
        let a = GameSidebar.collapsed
        let b = GameSidebar.collapsed
        #expect(a == b)
    }

    @Test("collapsed differs from expanded")
    func collapsedDiffersFromExpanded() {
        #expect(GameSidebar.collapsed != GameSidebar.expanded)
    }
}
