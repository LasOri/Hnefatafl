import Testing
@testable import Hnefatafl

@Suite("Undo Guard Tests")
struct UndoGuardTests {

    @Test("no confirmation needed with empty undo stack")
    func emptyStack() {
        let state = GameState()
        #expect(UndoGuard.needsConfirmation(state: state) == false)
    }

    @Test("no confirmation for early game moves")
    func earlyGame() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(UndoGuard.needsConfirmation(state: afterMove) == false)
    }

    @Test("confirmation needed when captures have occurred")
    func capturesOccurred() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        var afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let modifiedState = GameState(
            game: afterMove.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 2,
            defendersCaptured: 1,
            undoStack: afterMove.undoStack,
            captureHistory: [true, true]
        )
        #expect(UndoGuard.needsConfirmation(state: modifiedState) == true)
    }

    @Test("confirmation needed when many moves played")
    func manyMoves() {
        var captureHistory: [Bool] = Array(repeating: false, count: 20)
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let modifiedState = GameState(
            game: afterMove.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            undoStack: afterMove.undoStack,
            captureHistory: captureHistory
        )
        #expect(UndoGuard.needsConfirmation(state: modifiedState) == true)
    }

    @Test("threshold for move count is 10")
    func moveCountThreshold() {
        #expect(UndoGuard.moveCountThreshold == 10)
    }

    @Test("threshold for captures is 1")
    func captureThreshold() {
        #expect(UndoGuard.captureCountThreshold == 1)
    }

    @Test("confirmation message is non-empty")
    func messageNonEmpty() {
        #expect(!UndoGuard.confirmationMessage.isEmpty)
    }

    @Test("no confirmation needed just below thresholds")
    func belowThresholds() {
        let captureHistory: [Bool] = Array(repeating: false, count: 9)
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let modifiedState = GameState(
            game: afterMove.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            undoStack: afterMove.undoStack,
            captureHistory: captureHistory
        )
        #expect(UndoGuard.needsConfirmation(state: modifiedState) == false)
    }
}
