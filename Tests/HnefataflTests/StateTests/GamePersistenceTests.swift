import Testing
import Foundation
@testable import Hnefatafl

@Suite("Game Persistence Tests")
struct GamePersistenceTests {

    @Test("SaveState captures game position cells")
    func capturesPosition() {
        let state = GameState()
        let save = GameSerializer.serialize(state)
        #expect(save.cells.count == Position.cellCount)
    }

    @Test("SaveState captures current player")
    func capturesCurrentPlayer() {
        let state = GameState()
        let save = GameSerializer.serialize(state)
        #expect(save.currentPlayer == "attacker")
    }

    @Test("SaveState captures move history")
    func capturesMoveHistory() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let save = GameSerializer.serialize(afterMove)
        #expect(!save.moveHistory.isEmpty)
    }

    @Test("SaveState captures muted flag")
    func capturesMuted() {
        let muted = gameReducer(state: GameState(), action: GameAction.toggleMute)
        let save = GameSerializer.serialize(muted)
        #expect(save.muted == true)
    }

    @Test("SaveState captures difficulty")
    func capturesDifficulty() {
        let state = GameState()
        let save = GameSerializer.serialize(state)
        #expect(save.difficulty == "medium")
    }

    @Test("deserialize restores position")
    func restoresPosition() {
        let original = GameState()
        let save = GameSerializer.serialize(original)
        let restored = GameSerializer.deserialize(save)
        #expect(restored != nil)
        #expect(restored!.game.position == original.game.position)
    }

    @Test("deserialize restores current player")
    func restoresCurrentPlayer() {
        let original = GameState()
        let move = original.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: original, action: GameAction.makeMove(move))
        let save = GameSerializer.serialize(afterMove)
        let restored = GameSerializer.deserialize(save)
        #expect(restored!.game.currentPlayer == afterMove.game.currentPlayer)
    }

    @Test("deserialize restores muted and difficulty")
    func restoresSettings() {
        var state = gameReducer(state: GameState(), action: GameAction.toggleMute)
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
        let save = GameSerializer.serialize(state)
        let restored = GameSerializer.deserialize(save)!
        #expect(restored.muted == true)
        #expect(restored.aiDifficulty == .hard)
    }

    @Test("SaveState is Codable — round trips through JSON")
    func codableRoundTrip() {
        let state = GameState()
        let save = GameSerializer.serialize(state)
        let encoder = JSONEncoder()
        let data = try! encoder.encode(save)
        let decoder = JSONDecoder()
        let decoded = try! decoder.decode(SaveState.self, from: data)
        #expect(decoded.cells.count == save.cells.count)
        #expect(decoded.currentPlayer == save.currentPlayer)
    }

    @Test("deserialize returns nil for invalid data")
    func invalidDataReturnsNil() {
        let bad = SaveState(
            cells: [],
            currentPlayer: "invalid",
            moveHistory: [],
            muted: false,
            difficulty: "medium"
        )
        let result = GameSerializer.deserialize(bad)
        #expect(result == nil)
    }
}
