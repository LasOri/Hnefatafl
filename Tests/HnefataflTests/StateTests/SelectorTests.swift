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

    @Test("selectSelectedSquare returns nil initially")
    func namedSelectSelectedSquare_nil() {
        let store = createGameStore()
        let result = selectSelectedSquare(store: store)
        #expect(result.get() == nil)
    }

    @Test("selectLegalMoves returns empty initially")
    func namedSelectLegalMoves_empty() {
        let store = createGameStore()
        let result = selectLegalMoves(store: store)
        #expect(result.get().isEmpty)
    }

    @Test("selectAttackersCaptured returns zero initially")
    func namedSelectAttackersCaptured_zero() {
        let store = createGameStore()
        let result = selectAttackersCaptured(store: store)
        #expect(result.get() == 0)
    }

    @Test("selectDefendersCaptured returns zero initially")
    func namedSelectDefendersCaptured_zero() {
        let store = createGameStore()
        let result = selectDefendersCaptured(store: store)
        #expect(result.get() == 0)
    }

    @Test("selectAIMode returns humanVsHuman initially")
    func namedSelectAIMode_humanVsHuman() {
        let store = createGameStore()
        let result = selectAIMode(store: store)
        #expect(result.get() == .humanVsHuman)
    }

    @Test("selectMuted returns false initially")
    func namedSelectMuted_false() {
        let store = createGameStore()
        let result = selectMuted(store: store)
        #expect(result.get() == false)
    }

    @Test("selectLastMove returns nil initially")
    func namedSelectLastMove_nil() {
        let store = createGameStore()
        let result = selectLastMove(store: store)
        #expect(result.get() == nil)
    }

    @Test("selectFocusedSquare returns (0,0) initially")
    func namedSelectFocusedSquare_zeroZero() {
        let store = createGameStore()
        let result = selectFocusedSquare(store: store)
        #expect(result.get()?.row == 0)
        #expect(result.get()?.col == 0)
    }

    @Test("selectSelectedSquare updates after selectSquare")
    func namedSelectSelectedSquare_updates() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        let result = selectSelectedSquare(store: store)
        #expect(result.get()?.row == 0)
        #expect(result.get()?.col == 3)
    }

    @Test("selectLegalMoves populated after selectSquare")
    func namedSelectLegalMoves_populated() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        let result = selectLegalMoves(store: store)
        #expect(!result.get().isEmpty)
    }

    @Test("selectAIMode updates after toggleAI")
    func namedSelectAIMode_updates() {
        let store = createGameStore()
        store.dispatch(GameAction.toggleAI)
        let result = selectAIMode(store: store)
        #expect(result.get() != .humanVsHuman)
    }

    @Test("selectMuted updates after toggleMute")
    func namedSelectMuted_updates() {
        let store = createGameStore()
        store.dispatch(GameAction.toggleMute)
        let result = selectMuted(store: store)
        #expect(result.get() == true)
    }

    @Test("selectLastMove updates after makeMove")
    func namedSelectLastMove_updates() {
        let store = createGameStore()
        let move = store.getState().game.position.allLegalMoves(for: .attacker).first!
        store.dispatch(GameAction.makeMove(move))
        let result = selectLastMove(store: store)
        #expect(result.get() != nil)
    }

    @Test("selectFocusedSquare updates after moveFocus")
    func namedSelectFocusedSquare_updates() {
        let store = createGameStore()
        store.dispatch(GameAction.moveFocus(.down))
        let result = selectFocusedSquare(store: store)
        #expect(result.get()?.row == 1)
        #expect(result.get()?.col == 0)
    }
}
