import Testing
@testable import Hnefatafl

@Suite("Action Bar Tests")
struct ActionBarTests {

    @Test("always returns four items")
    func fourItems() {
        let items = ActionBar.items(canUndo: false, canRedo: false, gameOver: false)
        #expect(items.count == 4)
    }

    @Test("undo enabled when canUndo is true")
    func undoEnabled() {
        let items = ActionBar.items(canUndo: true, canRedo: false, gameOver: false)
        let undo = items.first { $0.id == "undo" }!
        #expect(undo.enabled == true)
    }

    @Test("redo disabled when canRedo is false")
    func redoDisabled() {
        let items = ActionBar.items(canUndo: false, canRedo: false, gameOver: false)
        let redo = items.first { $0.id == "redo" }!
        #expect(redo.enabled == false)
    }

    @Test("new game always enabled")
    func newGameAlwaysEnabled() {
        let items = ActionBar.items(canUndo: false, canRedo: false, gameOver: true)
        let newGame = items.first { $0.id == "new-game" }!
        #expect(newGame.enabled == true)
    }

    @Test("game over disables undo and redo")
    func gameOverDisables() {
        let items = ActionBar.items(canUndo: true, canRedo: true, gameOver: true)
        let undo = items.first { $0.id == "undo" }!
        let redo = items.first { $0.id == "redo" }!
        #expect(undo.enabled == false)
        #expect(redo.enabled == false)
    }
}
