import Testing
import LINKER
@testable import Hnefatafl

@Suite("Phase H Integration Tests", .serialized)
struct PhaseHIntegrationTests {

    @Test("muteToggle via store updates state")
    func muteToggleViaStore() {
        let store = createGameStore()
        store.dispatch(GameAction.toggleMute)
        #expect(store.getState().muted == true)
    }

    @Test("muted preserved across full game cycle")
    func mutedPreservedAcrossGameCycle() {
        let store = createGameStore()
        store.dispatch(GameAction.toggleMute)
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        #expect(store.getState().muted == true)
        let move = store.getState().game.position.allLegalMoves(for: store.getState().game.currentPlayer).first!
        store.dispatch(GameAction.makeMove(move))
        #expect(store.getState().muted == true)
        store.dispatch(GameAction.undo)
        #expect(store.getState().muted == true)
        store.dispatch(GameAction.newGame)
        #expect(store.getState().muted == true)
    }

    @Test("captureHistory grows with moves")
    func captureHistoryGrows() {
        let state = GameState()
        let move1 = state.game.position.allLegalMoves(for: .attacker).first!
        let after1 = gameReducer(state: state, action: GameAction.makeMove(move1))
        #expect(after1.captureHistory.count >= 1)
        let move2 = after1.game.position.allLegalMoves(for: after1.game.currentPlayer).first!
        let after2 = gameReducer(state: after1, action: GameAction.makeMove(move2))
        #expect(after2.captureHistory.count >= 2)
    }

    @Test("captureHistory reset on newGame")
    func captureHistoryResetOnNewGame() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(!afterMove.captureHistory.isEmpty)
        let afterNew = gameReducer(state: afterMove, action: GameAction.newGame)
        #expect(afterNew.captureHistory.isEmpty)
    }

    @Test("pendingSoundEffect set on selectSquare")
    func soundOnSelect() {
        let store = createGameStore()
        store.dispatch(GameAction.selectSquare(row: 0, col: 3))
        #expect(store.getState().pendingSoundEffect == .select)
    }

    @Test("pendingSoundEffect set on makeMove")
    func soundOnMove() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(afterMove.pendingSoundEffect != nil)
    }

    @Test("lastMove tracks through store dispatch")
    func lastMoveTracked() {
        let store = createGameStore()
        let move = store.getState().game.position.allLegalMoves(for: .attacker).first!
        store.dispatch(GameAction.makeMove(move))
        #expect(store.getState().lastMove != nil)
    }

    @Test("capturedSquares populated on capture move")
    func capturedSquaresOnCapture() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let captureMove = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let afterCapture = gameReducer(state: state, action: GameAction.makeMove(captureMove))
        #expect(!afterCapture.capturedSquares.isEmpty)
    }
}
