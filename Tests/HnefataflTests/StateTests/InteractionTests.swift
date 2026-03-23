import Testing
import LINKER
@testable import Hnefatafl

@Suite("Interaction Tests")
struct InteractionTests {

    @Test("clicking own piece selects it")
    func selectOwnPiece_storesSelection() {
        let store = createGameStore()

        store.dispatch(GameAction.selectSquare(row: 0, col: 3))

        let state = store.getState()
        #expect(state.selectedSquare?.row == 0)
        #expect(state.selectedSquare?.col == 3)
        #expect(!state.legalMovesForSelected.isEmpty)
    }

    @Test("clicking legal move square makes the move")
    func selectLegalMove_makesMove() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        let legalMove = store.getState().legalMovesForSelected[0]

        store.dispatch(GameAction.makeMove(legalMove))

        let state = store.getState()
        #expect(state.game.currentPlayer == .defender)
        #expect(state.selectedSquare == nil)
    }

    @Test("clicking non-legal square deselects")
    func selectNonLegal_deselects() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        #expect(store.getState().selectedSquare != nil)

        store.dispatch(GameAction.selectSquare(row: 2, col: 2))

        #expect(store.getState().selectedSquare == nil)
    }

    @Test("cannot select opponent's piece")
    func selectOpponent_noChange() {
        let store = createGameStore()

        store.dispatch(GameAction.selectSquare(row: 5, col: 5))

        #expect(store.getState().selectedSquare == nil)
    }

    @Test("selecting different own piece changes selection")
    func selectDifferentOwnPiece_changesSelection() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        #expect(store.getState().selectedSquare?.col == 3)

        store.dispatch(GameAction.selectSquare(row: 0, col: 4))

        #expect(store.getState().selectedSquare?.col == 4)
    }
}
