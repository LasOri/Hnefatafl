import Testing
@testable import Hnefatafl

@Suite("AIGameLoop Tests")
struct AIGameLoopTests {

    @Test("AI mode enum has human vs human")
    func aiMode_humanVsHuman() {
        let mode = AIMode.humanVsHuman
        #expect(mode == .humanVsHuman)
    }

    @Test("AI mode enum has human vs AI")
    func aiMode_humanVsAI() {
        let mode = AIMode.humanVsAI(humanSide: .defender)
        if case .humanVsAI(let side) = mode {
            #expect(side == .defender)
        } else {
            Issue.record("Expected humanVsAI")
        }
    }

    @Test("AIGameLoop returns nil move in human vs human mode")
    func humanVsHuman_noAIMove() {
        let game = Game()
        let move = AIGameLoop.aiMove(game: game, mode: .humanVsHuman)
        #expect(move == nil)
    }

    @Test("AIGameLoop returns move when it is AI's turn")
    func aiTurn_returnsMove() {
        let game = Game()
        let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .defender))

        #expect(move != nil)
    }

    @Test("AIGameLoop returns nil when it is human's turn")
    func humanTurn_returnsNil() {
        let game = Game()
        let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .attacker))

        #expect(move == nil)
    }

    @Test("AIGameLoop returns nil when game is over")
    func gameOver_returnsNil() {
        let position = emptyBoard().placing(.king, row: 0, col: 0).build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])

        let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .attacker))
        #expect(move == nil)
    }

    @Test("AI move is valid for the current position")
    func aiMove_isValid() {
        let game = Game()
        guard let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .defender)) else {
            Issue.record("Expected a move")
            return
        }

        let allMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(allMoves.contains(move))
    }

    @Test("toggleAI action switches mode")
    func toggleAI_switchesMode() {
        let state = GameState()
        let newState = gameReducer(state: state, action: GameAction.toggleAI)

        #expect(newState.aiMode != state.aiMode)
    }
}
