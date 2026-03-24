import Testing
@testable import Hnefatafl

@Suite("Drag Drop Manager Tests")
struct DragDropManagerTests {

    @Test("startDrag on own piece returns selectSquare action")
    func startDragOnOwnPiece() {
        let state = GameState()
        let action = DragDropManager.startDrag(row: 0, col: 3, state: state)
        if case .selectSquare(let r, let c) = action {
            #expect(r == 0)
            #expect(c == 3)
        } else {
            Issue.record("Expected selectSquare")
        }
    }

    @Test("startDrag on empty square returns nil")
    func startDragOnEmpty() {
        let state = GameState()
        let action = DragDropManager.startDrag(row: 2, col: 2, state: state)
        #expect(action == nil)
    }

    @Test("startDrag on opponent piece returns nil")
    func startDragOnOpponentPiece() {
        let state = GameState()
        let action = DragDropManager.startDrag(row: 5, col: 5, state: state)
        #expect(action == nil)
    }

    @Test("completeDrop on legal move square returns makeMove")
    func completeDropOnLegalMove() {
        let state = GameState()
        let selected = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        let legalMove = selected.legalMovesForSelected.first!
        let action = DragDropManager.completeDrop(row: legalMove.toRow, col: legalMove.toCol, state: selected)
        #expect(action != nil)
        if case .makeMove(let move) = action {
            #expect(move == legalMove)
        } else {
            Issue.record("Expected makeMove")
        }
    }

    @Test("completeDrop on illegal square returns nil")
    func completeDropOnIllegalSquare() {
        let state = GameState()
        let selected = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        let action = DragDropManager.completeDrop(row: 5, col: 5, state: selected)
        #expect(action == nil)
    }

    @Test("completeDrop with no selection returns nil")
    func completeDropWithNoSelection() {
        let state = GameState()
        let action = DragDropManager.completeDrop(row: 0, col: 5, state: state)
        #expect(action == nil)
    }

    @Test("canDrop returns true for legal move target")
    func canDropOnLegalTarget() {
        let state = GameState()
        let selected = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        let legalMove = selected.legalMovesForSelected.first!
        #expect(DragDropManager.canDrop(row: legalMove.toRow, col: legalMove.toCol, state: selected))
    }

    @Test("canDrop returns false for non-legal square")
    func canDropOnNonLegal() {
        let state = GameState()
        let selected = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        #expect(!DragDropManager.canDrop(row: 5, col: 5, state: selected))
    }

    @Test("CSS contains dragging class")
    func cssContainsDragging() {
        #expect(GameStyleSheet.css.contains(".dragging"))
    }

    @Test("CSS contains cursor grab for pieces")
    func cssContainsCursorGrab() {
        #expect(GameStyleSheet.css.contains("cursor: grab"))
    }
}
