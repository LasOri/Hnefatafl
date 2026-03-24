import Testing
@testable import Hnefatafl

@Suite("Reduced Motion Tests")
struct ReducedMotionTests {

    @Test("CSS contains prefers-reduced-motion media query")
    func containsMediaQuery() {
        #expect(GameStyleSheet.css.contains("prefers-reduced-motion"))
    }

    @Test("CSS contains animation: none inside reduced motion block")
    func containsAnimationNone() {
        let css = GameStyleSheet.css
        guard let range = css.range(of: "prefers-reduced-motion") else {
            Issue.record("Missing prefers-reduced-motion")
            return
        }
        let afterQuery = String(css[range.upperBound...])
        #expect(afterQuery.contains("animation: none"))
    }

    @Test("CSS contains transition: none inside reduced motion block")
    func containsTransitionNone() {
        let css = GameStyleSheet.css
        guard let range = css.range(of: "prefers-reduced-motion") else {
            Issue.record("Missing prefers-reduced-motion")
            return
        }
        let afterQuery = String(css[range.upperBound...])
        #expect(afterQuery.contains("transition: none"))
    }
}
