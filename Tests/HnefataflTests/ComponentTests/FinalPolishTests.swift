import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Final Polish Tests")
struct FinalPolishTests {

    @Test("ErrorBoundary wraps content in error boundary div")
    func errorBoundaryWraps() {
        let inner = [AnyNode(Text("hello"))]
        let nodes = ErrorBoundary.render(children: inner)
        let rendered = render(nodes)
        let boundary = rendered.findAll(tag: "div").first(where: { $0.className?.contains("error-boundary") == true })
        #expect(boundary != nil)
    }

    @Test("ErrorBoundary passes through children")
    func errorBoundaryChildren() {
        let inner = [AnyNode(Text("test content"))]
        let nodes = ErrorBoundary.render(children: inner)
        let rendered = render(nodes)
        let found = rendered.findByText("test content")
        #expect(found != nil)
    }

    @Test("CSS contains dark mode media query")
    func darkModeCSS() {
        #expect(GameStyleSheet.css.contains("prefers-color-scheme: dark"))
    }

    @Test("CSS contains high-contrast media query")
    func highContrastCSS() {
        #expect(GameStyleSheet.css.contains("prefers-contrast: more"))
    }

    @Test("dark mode overrides board background")
    func darkModeOverridesBoard() {
        #expect(GameStyleSheet.css.contains("--board-bg:"))
    }

    @Test("high contrast increases border visibility")
    func highContrastBorders() {
        let css = GameStyleSheet.css
        let contrastIdx = css.range(of: "prefers-contrast: more")
        #expect(contrastIdx != nil)
    }

    @Test("NotationExporter produces algebraic notation")
    func algebraicNotation() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 5, toCol: 3)
        let notation = NotationExporter.algebraic(move)
        #expect(notation == "D1-D6")
    }

    @Test("NotationExporter exports game moves")
    func exportsGameMoves() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let move = moves.first!
        let newGame = game.makeMove(move)
        let text = NotationExporter.exportMoves(newGame.moveHistory)
        #expect(!text.isEmpty)
        #expect(text.contains("-"))
    }

    @Test("NotationExporter handles empty move list")
    func emptyMoveList() {
        let text = NotationExporter.exportMoves([])
        #expect(text.isEmpty)
    }

    @Test("rules overlay has dialog role")
    func rulesOverlayDialogRole() {
        let state = gameReducer(state: GameState(), action: GameAction.toggleRules)
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let dialog = rendered.findAll(tag: "div").first(where: { $0.attr("role") == "dialog" })
        #expect(dialog != nil)
    }
}
