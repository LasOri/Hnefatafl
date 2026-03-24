import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Replay System Tests")
struct ReplaySystemTests {

    @Test("ReplayController returns position at step 0")
    func positionAtStepZero() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let pos = ReplayController.position(at: 0, in: afterMove)
        #expect(pos == game.position)
    }

    @Test("ReplayController returns position at last step")
    func positionAtLastStep() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        let pos = ReplayController.position(at: 1, in: afterMove)
        #expect(pos == afterMove.position)
    }

    @Test("ReplayController clamps out-of-range step")
    func clampsStep() {
        let game = Game()
        let pos = ReplayController.position(at: 99, in: game)
        #expect(pos == game.position)
    }

    @Test("ReplayController totalSteps equals positionHistory count")
    func totalSteps() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let afterMove = game.makeMove(move)
        #expect(ReplayController.totalSteps(in: afterMove) == 2)
    }

    @Test("replayStep defaults to nil in GameState")
    func defaultsToNil() {
        let state = GameState()
        #expect(state.replayStep == nil)
    }

    @Test("replayForward action increments step")
    func forwardIncrements() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let entered = gameReducer(state: afterMove, action: GameAction.enterReplay)
        #expect(entered.replayStep == 1)
        let back = gameReducer(state: entered, action: GameAction.replayBack)
        #expect(back.replayStep == 0)
        let forward = gameReducer(state: back, action: GameAction.replayForward)
        #expect(forward.replayStep == 1)
    }

    @Test("exitReplay clears replayStep")
    func exitClears() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let entered = gameReducer(state: afterMove, action: GameAction.enterReplay)
        let exited = gameReducer(state: entered, action: GameAction.exitReplay)
        #expect(exited.replayStep == nil)
    }

    @Test("EventWiring maps replay actions")
    func eventWiringMaps() {
        #expect(EventWiring.actionForButton("enter-replay") != nil)
        #expect(EventWiring.actionForButton("exit-replay") != nil)
        #expect(EventWiring.actionForButton("replay-forward") != nil)
        #expect(EventWiring.actionForButton("replay-back") != nil)
    }
}
