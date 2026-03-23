import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("AppComponent Tests")
struct AppComponentTests {

    @Test("renders board component")
    func rendersBoard() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let board = rendered.findAll(tag: "div").filter {
            $0.className?.contains("board") == true
        }
        #expect(!board.isEmpty)
    }

    @Test("renders status component")
    func rendersStatus() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let status = rendered.findAll(tag: "div").filter {
            $0.className?.contains("status") == true
        }
        #expect(!status.isEmpty)
    }

    @Test("renders move history panel")
    func rendersMoveHistory() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let history = rendered.findAll(tag: "div").filter {
            $0.className?.contains("move-history-panel") == true
        }
        #expect(!history.isEmpty)
    }

    @Test("has app container with viking-app class")
    func hasAppContainer() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let app = rendered.findAll(tag: "div").filter {
            $0.className?.contains("viking-app") == true
        }
        #expect(app.count == 1)
    }

    @Test("shows game over overlay when game is won")
    func showsGameOverOnWin() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let overlay = rendered.findAll(tag: "div").filter {
            $0.className?.contains("game-over-overlay") == true
        }
        #expect(!overlay.isEmpty)
    }

    @Test("does not show overlay when game in progress")
    func noOverlayInProgress() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let overlay = rendered.findAll(tag: "div").filter {
            $0.className?.contains("game-over-overlay") == true
        }
        #expect(overlay.isEmpty)
    }

    @Test("has new game button")
    func hasNewGameButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button")
        let newGameBtn = buttons.filter {
            $0.attr("data-action") == "new-game"
        }
        #expect(newGameBtn.count == 1)
    }

    @Test("has undo button")
    func hasUndoButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)

        let buttons = rendered.findAll(tag: "button")
        let undoBtn = buttons.filter {
            $0.attr("data-action") == "undo"
        }
        #expect(undoBtn.count == 1)
    }
}
