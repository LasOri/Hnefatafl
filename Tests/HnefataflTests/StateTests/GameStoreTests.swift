import Testing
import LINKER
@testable import Hnefatafl

@Suite("GameStore Tests")
struct GameStoreTests {

    @Test("store initializes with Copenhagen start")
    func store_initialState_isCopenhagen() {
        let store = createGameStore()

        let state = store.getState()

        #expect(state.game.currentPlayer == .attacker)
        #expect(state.game.position.pieceAt(row: 5, col: 5) == .king)
    }

    @Test("dispatching action updates store state")
    func store_dispatch_updatesState() {
        let store = createGameStore()

        store.dispatch(GameAction.selectSquare(row: 0, col: 3))

        let state = store.getState()
        #expect(state.selectedSquare?.row == 0)
        #expect(state.selectedSquare?.col == 3)
    }

    @Test("store dispatches makeMove and updates position")
    func store_makeMove_updatesPosition() {
        let store = createGameStore()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)

        store.dispatch(GameAction.makeMove(move))

        let state = store.getState()
        #expect(state.game.currentPlayer == .defender)
        #expect(state.game.position.pieceAt(row: 0, col: 2) == .attacker)
    }
}
