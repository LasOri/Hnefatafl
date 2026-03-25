import Testing
@testable import Hnefatafl

@Suite("GameControlPanel Tests")
struct GameControlPanelTests {
    @Test("New game has no undo or resign")
    func newGame() {
        let panel = GameControlPanel.forGame(moveCount: 0, isGameOver: false)
        #expect(panel.canUndo == false)
        #expect(panel.canRedo == false)
        #expect(panel.canResign == false)
        #expect(panel.isPaused == false)
    }

    @Test("Active game with moves allows undo and resign")
    func activeGameWithMoves() {
        let panel = GameControlPanel.forGame(moveCount: 5, isGameOver: false)
        #expect(panel.canUndo == true)
        #expect(panel.canResign == true)
    }

    @Test("Game over disables undo and resign")
    func gameOverDisablesActions() {
        let panel = GameControlPanel.forGame(moveCount: 10, isGameOver: true)
        #expect(panel.canUndo == false)
        #expect(panel.canResign == false)
    }

    @Test("Redo defaults to false")
    func redoDefaultsFalse() {
        let panel = GameControlPanel.forGame(moveCount: 3, isGameOver: false)
        #expect(panel.canRedo == false)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = GameControlPanel.forGame(moveCount: 5, isGameOver: false)
        let b = GameControlPanel.forGame(moveCount: 5, isGameOver: false)
        let c = GameControlPanel.forGame(moveCount: 0, isGameOver: false)
        #expect(a == b)
        #expect(a != c)
    }

    @Test("Pause defaults to false")
    func pauseDefaultsFalse() {
        let panel = GameControlPanel.forGame(moveCount: 2, isGameOver: false)
        #expect(panel.isPaused == false)
    }

    @Test("Single move enables undo")
    func singleMoveEnablesUndo() {
        let panel = GameControlPanel.forGame(moveCount: 1, isGameOver: false)
        #expect(panel.canUndo == true)
        #expect(panel.canResign == true)
    }
}
