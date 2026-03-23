import Testing
@testable import Hnefatafl

@Suite("EventWiring Tests")
struct EventWiringTests {

    @Test("square click with no selection dispatches selectSquare")
    func squareClick_selectsSquare() {
        let action = EventWiring.actionForSquareClick(row: 3, col: 5, state: GameState())

        guard case .selectSquare(let r, let c) = action else {
            Issue.record("Expected selectSquare, got \(String(describing: action))")
            return
        }
        #expect(r == 3)
        #expect(c == 5)
    }

    @Test("square click on legal move dispatches makeMove")
    func squareClick_makesMove() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)]
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: moves,
            attackersCaptured: 0,
            defendersCaptured: 0
        )

        let action = EventWiring.actionForSquareClick(row: 0, col: 5, state: state)

        guard case .makeMove(let move) = action else {
            Issue.record("Expected makeMove, got \(String(describing: action))")
            return
        }
        #expect(move.toRow == 0)
        #expect(move.toCol == 5)
    }

    @Test("square click on non-legal move deselects")
    func squareClick_deselects() {
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )

        let action = EventWiring.actionForSquareClick(row: 5, col: 5, state: state)

        guard case .selectSquare(let r, let c) = action else {
            Issue.record("Expected selectSquare, got \(String(describing: action))")
            return
        }
        #expect(r == 5)
        #expect(c == 5)
    }

    @Test("arrow up dispatches moveFocus up")
    func arrowUp_movesFocusUp() {
        let action = EventWiring.actionForKey("ArrowUp")

        guard case .moveFocus(let dir) = action else {
            Issue.record("Expected moveFocus, got \(String(describing: action))")
            return
        }
        #expect(dir == .up)
    }

    @Test("arrow down dispatches moveFocus down")
    func arrowDown_movesFocusDown() {
        let action = EventWiring.actionForKey("ArrowDown")

        guard case .moveFocus(let dir) = action else {
            Issue.record("Expected moveFocus, got \(String(describing: action))")
            return
        }
        #expect(dir == .down)
    }

    @Test("arrow left dispatches moveFocus left")
    func arrowLeft_movesFocusLeft() {
        let action = EventWiring.actionForKey("ArrowLeft")

        guard case .moveFocus(let dir) = action else {
            Issue.record("Expected moveFocus, got \(String(describing: action))")
            return
        }
        #expect(dir == .left)
    }

    @Test("arrow right dispatches moveFocus right")
    func arrowRight_movesFocusRight() {
        let action = EventWiring.actionForKey("ArrowRight")

        guard case .moveFocus(let dir) = action else {
            Issue.record("Expected moveFocus, got \(String(describing: action))")
            return
        }
        #expect(dir == .right)
    }

    @Test("Escape dispatches escape action")
    func escape_dispatches() {
        let action = EventWiring.actionForKey("Escape")

        guard case .escape = action else {
            Issue.record("Expected escape, got \(String(describing: action))")
            return
        }
    }

    @Test("Enter on focused square dispatches selectSquare")
    func enter_selectsFocused() {
        let state = GameState()
        let action = EventWiring.actionForEnter(state: state)

        guard case .selectSquare(let r, let c) = action else {
            Issue.record("Expected selectSquare, got \(String(describing: action))")
            return
        }
        #expect(r == 0)
        #expect(c == 0)
    }

    @Test("unknown key returns nil")
    func unknownKey_returnsNil() {
        let action = EventWiring.actionForKey("KeyX")
        #expect(action == nil)
    }

    @Test("actionForButton new-game returns newGame")
    func newGameButton_returnsNewGame() {
        let action = EventWiring.actionForButton("new-game")

        guard case .newGame = action else {
            Issue.record("Expected newGame, got \(String(describing: action))")
            return
        }
    }

    @Test("actionForButton undo returns undo")
    func undoButton_returnsUndo() {
        let action = EventWiring.actionForButton("undo")

        guard case .undo = action else {
            Issue.record("Expected undo, got \(String(describing: action))")
            return
        }
    }

    @Test("actionForButton unknown returns nil")
    func unknownButton_returnsNil() {
        let action = EventWiring.actionForButton("unknown")
        #expect(action == nil)
    }
}
