import Testing
import LINKER
@testable import Hnefatafl

@Suite("GameReducer Tests")
struct GameReducerTests {

    @Test("newGame action resets to initial state")
    func reduce_newGame_resetsState() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let modifiedGame = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let state = GameState(
            game: modifiedGame,
            selectedSquare: (row: 3, col: 5),
            legalMovesForSelected: [],
            attackersCaptured: 2,
            defendersCaptured: 1
        )

        let result = gameReducer(state: state, action: GameAction.newGame)

        #expect(result.game.currentPlayer == .attacker)
        #expect(result.selectedSquare == nil)
        #expect(result.attackersCaptured == 0)
    }

    @Test("selectSquare on own piece stores selection and legal moves")
    func reduce_selectOwnPiece_storesSelectionAndMoves() {
        let state = GameState()

        let result = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))

        #expect(result.selectedSquare?.row == 0)
        #expect(result.selectedSquare?.col == 3)
        #expect(!result.legalMovesForSelected.isEmpty)
    }

    @Test("selectSquare on opponent's piece does nothing")
    func reduce_selectOpponentPiece_noChange() {
        let state = GameState()

        let result = gameReducer(state: state, action: GameAction.selectSquare(row: 5, col: 5))

        #expect(result.selectedSquare == nil)
    }

    @Test("selectSquare on empty square with no selection does nothing")
    func reduce_selectEmpty_noSelection() {
        let state = GameState()

        let result = gameReducer(state: state, action: GameAction.selectSquare(row: 2, col: 2))

        #expect(result.selectedSquare == nil)
    }

    @Test("makeMove applies move and switches turn")
    func reduce_makeMove_appliesMoveAndSwitchesTurn() {
        let state = GameState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)

        let result = gameReducer(state: state, action: GameAction.makeMove(move))

        #expect(result.game.currentPlayer == .defender)
        #expect(result.game.position.pieceAt(row: 0, col: 2) == .attacker)
        #expect(result.selectedSquare == nil)
    }

    @Test("makeMove with capture increments captured count")
    func reduce_makeMoveWithCapture_incrementsCapturedCount() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 3)
            .placing(.defender, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let move = Move(fromRow: 5, fromCol: 6, toRow: 5, toCol: 5)

        let result = gameReducer(state: state, action: GameAction.makeMove(move))

        #expect(result.defendersCaptured == 1)
    }
}
