import Testing
@testable import Hnefatafl

@Suite("Undo Confirmation Tests")
struct UndoConfirmationTests {

    @Test("no moves means cannot undo")
    func noMovesCantUndo() {
        let result = UndoConfirmation.data(moveCount: 0)
        #expect(result.canUndo == false)
    }

    @Test("with moves can undo")
    func withMovesCanUndo() {
        let result = UndoConfirmation.data(moveCount: 3)
        #expect(result.canUndo == true)
    }

    @Test("message differs based on state")
    func messageDiffers() {
        let noMoves = UndoConfirmation.data(moveCount: 0)
        let hasMoves = UndoConfirmation.data(moveCount: 1)
        #expect(noMoves.message != hasMoves.message)
    }

    @Test("movesBack is always 1")
    func movesBackIsOne() {
        let result = UndoConfirmation.data(moveCount: 5)
        #expect(result.movesBack == 1)
    }

    @Test("empty game state produces correct data")
    func emptyGameState() {
        let result = UndoConfirmation.data(moveCount: 0)
        #expect(result.movesBack == 1)
        #expect(result.message == "No moves to undo")
        #expect(result.canUndo == false)
    }
}
