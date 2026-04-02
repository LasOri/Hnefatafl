import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Dialog Accessibility Tests")
struct DialogAccessibilityTests {

    @Test("rules overlay has aria-modal attribute set to true")
    func rulesOverlayHasAriaModal() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            showRules: true
        )
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let dialogs = rendered.findAll(tag: "div").filter {
            $0.attr("role") == "dialog"
        }
        #expect(!dialogs.isEmpty)
        #expect(dialogs.first?.attr("aria-modal") == "true")
    }

    @Test("rules overlay has aria-label")
    func rulesOverlayHasAriaLabel() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            showRules: true
        )
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let dialogs = rendered.findAll(tag: "div").filter {
            $0.attr("role") == "dialog"
        }
        #expect(dialogs.first?.attr("aria-label") == "Game rules")
    }

    @Test("rules overlay not rendered when showRules is false")
    func noDialogWhenRulesHidden() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let dialogs = rendered.findAll(tag: "div").filter {
            $0.attr("role") == "dialog"
        }
        #expect(dialogs.isEmpty)
    }
}
