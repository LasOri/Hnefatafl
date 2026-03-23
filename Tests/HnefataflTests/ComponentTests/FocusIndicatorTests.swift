import Testing
@testable import Hnefatafl
import LINKER
import LINKERTesting

@Suite("Focus Indicator Tests")
struct FocusIndicatorTests {

    @Test("focused square has focused class")
    func focusedSquareHasClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let squares = rendered.findAll(tag: "div").filter { $0.className?.contains("square") == true }
        let focused = squares.filter { $0.className?.contains("focused") == true }
        #expect(focused.count == 1)
    }

    @Test("non-focused squares do not have focused class")
    func nonFocusedSquaresNoClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let squares = rendered.findAll(tag: "div").filter { $0.className?.contains("square") == true }
        let nonFocused = squares.filter { $0.className?.contains("focused") != true }
        #expect(nonFocused.count == Position.boardSize * Position.boardSize - 1)
    }

    @Test("focus and selection can coexist on same square")
    func focusAndSelectionCoexist() {
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 0),
            legalMovesForSelected: [],
            focusedSquare: (row: 0, col: 0)
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let squares = rendered.findAll(tag: "div").filter { $0.className?.contains("square") == true }
        let bothClasses = squares.filter {
            $0.className?.contains("focused") == true && $0.className?.contains("selected") == true
        }
        #expect(bothClasses.count == 1)
    }

    @Test("CSS contains focused rule")
    func cssContainsFocusedRule() {
        #expect(GameStyleSheet.css.contains(".focused"))
    }
}
