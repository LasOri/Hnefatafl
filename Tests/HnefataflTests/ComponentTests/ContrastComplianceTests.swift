import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("WCAG Contrast Compliance Tests")
struct ContrastComplianceTests {

    @Test("VikingColors.textMuted equals updated contrast-safe value")
    func textMutedTokenValue() {
        #expect(VikingColors.textMuted == "#a09a94")
    }

    @Test("CSS contains updated --text-muted custom property")
    func cssContainsUpdatedTextMuted() {
        let css = VikingStyleSheet.css
        #expect(css.contains("--text-muted: #a09a94"))
    }

    @Test("CSS uses transparent outline instead of outline none for p2p-input")
    func cssUsesTransparentOutline() {
        let css = VikingStyleSheet.css
        #expect(css.contains("outline: 2px solid transparent"))
        #expect(!css.contains("outline: none"))
    }
}
