import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("New Game Confirm Dialog Tests")
struct NewGameConfirmTests {

    @Test("new game button has data-confirm attribute")
    func newGameButtonHasDataConfirm() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button")
        let newGameBtn = buttons.filter {
            $0.attr("data-action") == "new-game"
        }
        #expect(newGameBtn.count == 1)
        #expect(newGameBtn.first?.attr("data-confirm") != nil)
    }

    @Test("data-confirm contains appropriate warning message")
    func dataConfirmMessageContent() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button")
        let newGameBtn = buttons.first {
            $0.attr("data-action") == "new-game"
        }
        let confirmMsg = newGameBtn?.attr("data-confirm") ?? ""
        #expect(confirmMsg.contains("new game"))
    }
}
