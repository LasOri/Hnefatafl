import Testing
@testable import Hnefatafl

@Suite("Touch and Mobile Tests")
struct TouchAndMobileTests {

    @Test("CSS contains touch-action none on board")
    func touchActionOnBoard() {
        #expect(GameStyleSheet.css.contains("touch-action"))
    }

    @Test("CSS contains tap target sizing for interactive elements")
    func minTapTargetSize() {
        // Buttons maintain 44px min-height for WCAG tap targets
        #expect(GameStyleSheet.css.contains("min-height: 44px"))
        // Squares use grid-based responsive sizing (no hardcoded min-width)
        // to prevent overflow on mobile viewports
    }

    @Test("CSS contains mobile toolbar layout")
    func mobileToolbarLayout() {
        let css = GameStyleSheet.css
        #expect(css.contains("flex-wrap: wrap"))
    }

    @Test("CSS contains mobile button padding")
    func mobileButtonPadding() {
        let css = GameStyleSheet.css
        guard let mobileRange = css.range(of: "max-width: 600px") else {
            Issue.record("Missing mobile breakpoint")
            return
        }
        let afterBreakpoint = String(css[mobileRange.upperBound...])
        #expect(afterBreakpoint.contains("padding"))
    }

    @Test("CSS prevents text selection on board")
    func preventTextSelection() {
        #expect(GameStyleSheet.css.contains("user-select: none"))
    }

    @Test("CSS has viewport-relative board sizing")
    func viewportRelativeSizing() {
        #expect(GameStyleSheet.css.contains("100vw"))
    }

    @Test("TouchCoordinateParser extracts row and col from touch position")
    func touchCoordinateParser() {
        let result = TouchCoordinateParser.squareFromPosition(
            x: 120, y: 80,
            boardWidth: 440, boardHeight: 440,
            boardSize: 11
        )
        #expect(result != nil)
        #expect(result!.row >= 0 && result!.row < 11)
        #expect(result!.col >= 0 && result!.col < 11)
    }

    @Test("TouchCoordinateParser returns nil for out-of-bounds")
    func touchOutOfBounds() {
        let result = TouchCoordinateParser.squareFromPosition(
            x: -10, y: 500,
            boardWidth: 440, boardHeight: 440,
            boardSize: 11
        )
        #expect(result == nil)
    }
}
