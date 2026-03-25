import Testing
@testable import Hnefatafl

@Suite("Responsive Layout Tests")
struct ResponsiveLayoutTests {

    @Test("mobile breakpoint is 768")
    func mobileBreakpoint() {
        #expect(ResponsiveLayout.mobileBreakpoint == 768)
    }

    @Test("tablet breakpoint is 1024")
    func tabletBreakpoint() {
        #expect(ResponsiveLayout.tabletBreakpoint == 1024)
    }

    @Test("layout for mobile width")
    func mobileLayout() {
        let layout = ResponsiveLayout.forWidth(400)
        #expect(layout == .mobile)
    }

    @Test("layout for tablet width")
    func tabletLayout() {
        let layout = ResponsiveLayout.forWidth(900)
        #expect(layout == .tablet)
    }

    @Test("layout for desktop width")
    func desktopLayout() {
        let layout = ResponsiveLayout.forWidth(1200)
        #expect(layout == .desktop)
    }

    @Test("board size for mobile")
    func mobileBoardSize() {
        let size = ResponsiveLayout.boardSize(for: .mobile)
        #expect(size < ResponsiveLayout.boardSize(for: .desktop))
    }

    @Test("board size for desktop")
    func desktopBoardSize() {
        let size = ResponsiveLayout.boardSize(for: .desktop)
        #expect(size >= 500)
    }

    @Test("CSS media queries")
    func mediaQueries() {
        let css = ResponsiveLayout.mediaQueryCSS()
        #expect(css.contains("@media"))
        #expect(css.contains("768px"))
    }

    @Test("LayoutMode has three cases")
    func threeCases() {
        let modes: [LayoutMode] = [.mobile, .tablet, .desktop]
        #expect(modes.count == 3)
    }

    @Test("sidebar visible on desktop")
    func sidebarDesktop() {
        #expect(ResponsiveLayout.showSidebar(for: .desktop))
        #expect(!ResponsiveLayout.showSidebar(for: .mobile))
    }
}
