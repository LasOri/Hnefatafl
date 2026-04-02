import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("GameOverOverlay Keyboard Accessibility Tests")
struct GameOverOverlayKeyboardTests {

    @Test("Attacker wins overlay contains a Play Again button")
    func attackerWins_hasPlayAgainButton() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button").filter {
            $0.attr("data-action") == "new-game"
        }
        #expect(buttons.count == 1, "Expected exactly one Play Again button")
    }

    @Test("Defender wins overlay contains a Play Again button")
    func defenderWins_hasPlayAgainButton() {
        let nodes = GameOverOverlay.render(status: .defenderWins)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button").filter {
            $0.attr("data-action") == "new-game"
        }
        #expect(buttons.count == 1)
    }

    @Test("Draw overlay contains a Play Again button")
    func draw_hasPlayAgainButton() {
        let nodes = GameOverOverlay.render(status: .draw)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button").filter {
            $0.attr("data-action") == "new-game"
        }
        #expect(buttons.count == 1)
    }

    @Test("Play Again button has aria-label")
    func playAgainButton_hasAriaLabel() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let button = rendered.findAll(tag: "button").first {
            $0.attr("data-action") == "new-game"
        }
        #expect(button != nil)
        #expect(button?.attr("aria-label") == "Play again")
    }

    @Test("Play Again button has autofocus for keyboard users")
    func playAgainButton_hasAutofocus() {
        let nodes = GameOverOverlay.render(status: .defenderWins)
        let rendered = render(nodes)

        let button = rendered.findAll(tag: "button").first {
            $0.attr("data-action") == "new-game"
        }
        #expect(button != nil)
        #expect(button?.attr("autofocus") == "true")
    }

    @Test("Play Again button text reads Play Again")
    func playAgainButton_text() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let text = rendered.findByText("Play Again")
        #expect(text != nil)
    }

    @Test("Overlay has alertdialog role for screen readers")
    func overlay_hasAlertDialogRole() {
        let nodes = GameOverOverlay.render(status: .attackerWins)
        let rendered = render(nodes)

        let overlay = rendered.findAll(tag: "div").filter {
            $0.className?.contains("game-over-overlay") == true
        }.first
        #expect(overlay?.attr("role") == "alertdialog")
    }

    @Test("Overlay aria-label matches the game result text")
    func overlay_hasAriaLabel() {
        let nodes = GameOverOverlay.render(status: .defenderWins)
        let rendered = render(nodes)

        let overlay = rendered.findAll(tag: "div").filter {
            $0.className?.contains("game-over-overlay") == true
        }.first
        #expect(overlay?.attr("aria-label") == "Defenders Win")
    }

    @Test("In-progress returns empty — no overlay, no button")
    func inProgress_returnsEmpty() {
        let nodes = GameOverOverlay.render(status: .inProgress)
        #expect(nodes.isEmpty)
    }
}
