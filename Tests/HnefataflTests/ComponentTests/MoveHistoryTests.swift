import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("MoveHistory Tests", .serialized)
struct MoveHistoryTests {

    @Test("MoveHistoryComponent renders empty list at start")
    func render_emptyAtStart() {
        let state = GameState()
        let nodes = MoveHistoryComponent.render(state: state)
        let rendered = render(nodes)

        let items = rendered.findAll(tag: "li")

        #expect(items.isEmpty)
    }

    @Test("MoveHistoryComponent renders moves after play")
    func render_showsMovesAfterPlay() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let played = game.makeMove(moves[0])
        let state = GameState(
            game: played,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = MoveHistoryComponent.render(state: state)
        let rendered = render(nodes)

        let items = rendered.findAll(tag: "li")

        #expect(items.count == 1)
    }

    @Test("undo reverts to previous game state")
    func undo_revertsToPreviousState() {
        let store = createGameStore()
        let initialPosition = store.getState().game.position
        let moves = store.getState().game.position.allLegalMoves(for: .attacker)
        store.dispatch(GameAction.makeMove(moves[0]))
        #expect(store.getState().game.currentPlayer == .defender)

        store.dispatch(GameAction.undo)

        #expect(store.getState().game.currentPlayer == .attacker)
        #expect(store.getState().game.position == initialPosition)
    }

    @Test("undo at start does nothing")
    func undo_atStart_noChange() {
        let store = createGameStore()

        store.dispatch(GameAction.undo)

        #expect(store.getState().game.currentPlayer == .attacker)
        #expect(store.getState().game.moveHistory.isEmpty)
    }
}
