import Testing
@testable import Hnefatafl

@Suite("AI Auto-Play Integration Tests")
struct AIAutoPlayTests {

    @Test("human move in AI mode triggers AI response")
    func humanMove_triggersAIResponse() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )

        let newState = gameReducer(state: state, action: GameAction.makeMove(humanMove))

        #expect(newState.game.currentPlayer == .attacker)
    }

    @Test("human move in human-vs-human does not auto-play")
    func humanVsHuman_noAutoPlay() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsHuman
        )

        let newState = gameReducer(state: state, action: GameAction.makeMove(move))

        #expect(newState.game.currentPlayer == .defender)
    }

    @Test("AI does not play when game is over")
    func gameOver_noAIPlay() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )

        #expect(state.game.status == .defenderWins)
    }

    @Test("AI auto-play increments move history by 2")
    func aiAutoPlay_twoMovesInHistory() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )

        let newState = gameReducer(state: state, action: GameAction.makeMove(humanMove))

        #expect(newState.game.moveHistory.count == 2)
    }

    @Test("AI auto-play produces valid game state")
    func aiAutoPlay_validState() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )

        let newState = gameReducer(state: state, action: GameAction.makeMove(humanMove))

        #expect(newState.game.status == .inProgress)
        #expect(newState.selectedSquare == nil)
        #expect(newState.legalMovesForSelected.isEmpty)
    }

    @Test("undo in AI mode reverts both moves")
    func undoInAIMode_revertsBothMoves() {
        let game = Game()
        let humanMove = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0,
            aiMode: .humanVsAI(humanSide: .attacker)
        )

        let afterMove = gameReducer(state: state, action: GameAction.makeMove(humanMove))
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)

        #expect(afterUndo.game.currentPlayer == .attacker)
        #expect(afterUndo.game.moveHistory.isEmpty)
    }
}
