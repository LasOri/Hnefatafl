import Testing
import LINKER
@testable import Hnefatafl

@Suite("Selector Tests")
struct SelectorTests {

    @Test("selectCurrentPlayer returns attacker at game start")
    func selectCurrentPlayer_start_isAttacker() {
        let store = createGameStore()

        let player = store.select(\.game.currentPlayer)

        #expect(player.get() == .attacker)
    }

    @Test("selectGameStatus returns inProgress at start")
    func selectGameStatus_start_isInProgress() {
        let store = createGameStore()

        let status = selectGameStatus(store: store)

        #expect(status.get() == .inProgress)
    }

    @Test("selectBoardCells returns 121 cells")
    func selectBoardCells_returns121() {
        let store = createGameStore()

        let cells = store.select(\.game.position.cells)

        #expect(cells.get().count == 121)
    }

    @Test("selectedSquare is nil initially")
    func selectSelectedSquare_isNil() {
        let state = createGameStore().getState()

        #expect(state.selectedSquare == nil)
    }

    @Test("selectAttackersCaptured starts at zero")
    func selectAttackersCaptured_startsZero() {
        let store = createGameStore()

        let captured = store.select(\.attackersCaptured)

        #expect(captured.get() == 0)
    }

    @Test("selectMoveHistory starts empty")
    func selectMoveHistory_startsEmpty() {
        let store = createGameStore()

        let history = store.select(\.game.moveHistory)

        #expect(history.get().isEmpty)
    }
}
