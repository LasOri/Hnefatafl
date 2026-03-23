import Testing
@testable import Hnefatafl

@Suite("Evaluation AI Integration Tests")
struct EvaluationAIIntegrationTests {

    @Test("AI auto-play with EvaluationAI produces valid state")
    func autoPlayValidState() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            aiMode: .humanVsAI(humanSide: .attacker)
        )
        let newState = gameReducer(state: state, action: GameAction.makeMove(humanMove))
        #expect(newState.game.status == .inProgress)
        #expect(newState.game.currentPlayer == .attacker)
    }

    @Test("EvaluationAI move is valid for game position")
    func moveIsValid() {
        let game = Game()
        let move = EvaluationAI.pickMove(game: game)
        #expect(move != nil)
        if let move {
            let legal = game.position.allLegalMoves(for: game.currentPlayer)
            #expect(legal.contains(where: { $0 == move }))
        }
    }

    @Test("undo after EvaluationAI move restores correctly")
    func undoRestores() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            aiMode: .humanVsAI(humanSide: .attacker)
        )
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(humanMove))
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)
        #expect(afterUndo.game.moveHistory.isEmpty)
        #expect(afterUndo.game.currentPlayer == .attacker)
    }

    @Test("game loop uses EvaluationAI")
    func gameLoopUsesEvalAI() {
        let game = Game()
        let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .defender))
        #expect(move != nil)
        if let move {
            let legal = game.position.allLegalMoves(for: .attacker)
            #expect(legal.contains(where: { $0 == move }))
        }
    }
}
