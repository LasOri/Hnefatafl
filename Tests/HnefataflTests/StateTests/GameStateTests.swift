import Testing
import LINKER
@testable import Hnefatafl

@Suite("GameState Tests")
struct GameStateTests {

    @Test("initial GameState has Copenhagen game and no selection")
    func initialState_hasGameAndNoSelection() {
        let state = GameState()

        #expect(state.game.currentPlayer == .attacker)
        #expect(state.selectedSquare == nil)
        #expect(state.legalMovesForSelected.isEmpty)
    }

    @Test("GameState tracks captured piece counts")
    func state_capturedCounts_startAtZero() {
        let state = GameState()

        #expect(state.attackersCaptured == 0)
        #expect(state.defendersCaptured == 0)
    }
}
