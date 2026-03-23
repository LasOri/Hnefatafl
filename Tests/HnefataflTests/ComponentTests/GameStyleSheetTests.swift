import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("GameStyleSheet Tests")
struct GameStyleSheetTests {

    @Test("renders a style element")
    func rendersStyleElement() {
        let nodes = GameStyleSheet.render()
        let rendered = render(nodes)

        let style = rendered.find(tag: "style")
        #expect(style != nil)
    }

    @Test("includes board grid layout")
    func includesBoardGrid() {
        let css = GameStyleSheet.css

        #expect(css.contains("display: grid"))
        #expect(css.contains("grid-template-columns"))
    }

    @Test("includes piece styling")
    func includesPieceStyling() {
        let css = GameStyleSheet.css

        #expect(css.contains(".piece-attacker"))
        #expect(css.contains(".piece-defender"))
        #expect(css.contains(".piece-king"))
    }

    @Test("includes selection glow")
    func includesSelectionGlow() {
        let css = GameStyleSheet.css

        #expect(css.contains(".glow"))
    }

    @Test("includes move indicator")
    func includesMoveIndicator() {
        let css = GameStyleSheet.css

        #expect(css.contains(".move-indicator"))
    }

    @Test("includes game over overlay styling")
    func includesOverlayStyling() {
        let css = GameStyleSheet.css

        #expect(css.contains(".game-over-overlay"))
    }

    @Test("includes capture effect animation")
    func includesCaptureAnimation() {
        let css = GameStyleSheet.css

        #expect(css.contains(".capture-effect"))
        #expect(css.contains("@keyframes"))
    }

    @Test("includes responsive design")
    func includesResponsive() {
        let css = GameStyleSheet.css

        #expect(css.contains("@media"))
    }

    @Test("includes viking theme colors")
    func includesVikingTheme() {
        let css = GameStyleSheet.css

        #expect(css.contains(".viking-theme"))
    }

    @Test("includes corner and throne special squares")
    func includesSpecialSquares() {
        let css = GameStyleSheet.css

        #expect(css.contains(".square-corner"))
        #expect(css.contains(".square-throne"))
    }
}
