import Testing
import LINKER
@testable import Hnefatafl

@Suite("Viking StyleSheet Tests")
struct VikingStyleSheetTests {

    @Test("render produces style element")
    func render_producesStyleElement() {
        let nodes = VikingStyleSheet.render()
        #expect(nodes.count == 1)
    }

    @Test("CSS contains root custom properties")
    func css_containsRootProperties() {
        #expect(VikingStyleSheet.css.contains("--viking-gold:"))
        #expect(VikingStyleSheet.css.contains("--viking-soot:"))
        #expect(VikingStyleSheet.css.contains("--viking-bone:"))
    }

    @Test("CSS contains viking-app class")
    func css_containsVikingApp() {
        #expect(VikingStyleSheet.css.contains(".viking-app"))
    }

    @Test("CSS contains board styling")
    func css_containsBoardStyling() {
        #expect(VikingStyleSheet.css.contains(".board"))
        #expect(VikingStyleSheet.css.contains(".square"))
        #expect(VikingStyleSheet.css.contains(".square-corner"))
        #expect(VikingStyleSheet.css.contains(".square-throne"))
    }

    @Test("CSS contains P2P connect styling")
    func css_containsP2PStyles() {
        #expect(VikingStyleSheet.css.contains(".p2p-connect"))
        #expect(VikingStyleSheet.css.contains(".p2p-panel"))
        #expect(VikingStyleSheet.css.contains(".p2p-input"))
        #expect(VikingStyleSheet.css.contains(".p2p-status-dot"))
    }

    @Test("CSS contains reduced motion media query")
    func css_containsReducedMotion() {
        #expect(VikingStyleSheet.css.contains("prefers-reduced-motion"))
    }

    @Test("CSS contains high contrast media query")
    func css_containsHighContrast() {
        #expect(VikingStyleSheet.css.contains("prefers-contrast: more"))
    }

    @Test("CSS contains dark mode media query")
    func css_containsDarkMode() {
        #expect(VikingStyleSheet.css.contains("prefers-color-scheme: dark"))
    }

    @Test("CSS contains rune-glow animation")
    func css_containsRuneGlow() {
        #expect(VikingStyleSheet.css.contains("rune-glow"))
    }

    @Test("CSS uses corrected iron color for WCAG")
    func css_usesCorrectIronColor() {
        #expect(VikingStyleSheet.css.contains("--viking-iron: #8a8580"))
    }

    @Test("CSS uses serif display font")
    func css_usesSerifDisplayFont() {
        #expect(VikingStyleSheet.css.contains("Georgia"))
    }

    @Test("CSS has mobile breakpoint")
    func css_hasMobileBreakpoint() {
        #expect(VikingStyleSheet.css.contains("max-width: 600px"))
    }
}
