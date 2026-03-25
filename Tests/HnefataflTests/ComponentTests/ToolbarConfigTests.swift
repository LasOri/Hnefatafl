import Testing
@testable import Hnefatafl

@Suite("Toolbar Config Tests")
struct ToolbarConfigTests {

    @Test("returns four items")
    func fourItems() {
        let items = ToolbarConfig.items(gameInProgress: true, canUndo: true)
        #expect(items.count == 4)
    }

    @Test("undo disabled when game not in progress")
    func undoDisabledNoGame() {
        let items = ToolbarConfig.items(gameInProgress: false, canUndo: true)
        let undo = items.first { $0.id == "undo" }
        #expect(undo?.enabled == false)
    }

    @Test("undo disabled when no moves to undo")
    func undoDisabledNoMoves() {
        let items = ToolbarConfig.items(gameInProgress: true, canUndo: false)
        let undo = items.first { $0.id == "undo" }
        #expect(undo?.enabled == false)
    }

    @Test("undo enabled when game in progress and can undo")
    func undoEnabled() {
        let items = ToolbarConfig.items(gameInProgress: true, canUndo: true)
        let undo = items.first { $0.id == "undo" }
        #expect(undo?.enabled == true)
    }

    @Test("new game always enabled")
    func newGameAlwaysEnabled() {
        let items = ToolbarConfig.items(gameInProgress: false, canUndo: false)
        let newGame = items.first { $0.id == "new" }
        #expect(newGame?.enabled == true)
    }
}
