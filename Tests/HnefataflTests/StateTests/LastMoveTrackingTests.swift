import Testing
@testable import Hnefatafl

@Suite("Last Move Tracking Tests")
struct LastMoveTrackingTests {

    @Test("lastMove is nil in initial state")
    func initialLastMove() {
        let state = GameState()
        #expect(state.lastMove == nil)
    }

    @Test("capturedSquares is empty in initial state")
    func initialCapturedSquares() {
        let state = GameState()
        #expect(state.capturedSquares.isEmpty)
    }

    @Test("pendingSoundEffect is nil in initial state")
    func initialPendingSoundEffect() {
        let state = GameState()
        #expect(state.pendingSoundEffect == nil)
    }

    @Test("makeMove sets lastMove to the move made")
    func makeMoveUpdatesLastMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.lastMove != nil)
    }

    @Test("newGame clears lastMove")
    func newGameClearsLastMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterNew = gameReducer(state: afterMove, action: GameAction.newGame)
        #expect(afterNew.lastMove == nil)
    }

    @Test("undo clears lastMove")
    func undoClearsLastMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)
        #expect(afterUndo.lastMove == nil)
    }

    @Test("selectSquare clears lastMove")
    func selectSquareClearsLastMove() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterSelect = gameReducer(state: afterMove, action: GameAction.selectSquare(row: 3, col: 5))
        #expect(afterSelect.lastMove == nil)
    }

    @Test("makeMove without capture has empty capturedSquares")
    func noCaptureEmptyCapturedSquares() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.capturedSquares.isEmpty)
    }

    @Test("makeMove with capture populates capturedSquares")
    func capturePopulatesCapturedSquares() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.capturedSquares.count == 1)
        #expect(newState.capturedSquares.first?.row == 3)
        #expect(newState.capturedSquares.first?.col == 1)
    }

    @Test("pendingSoundEffect is .capture on capture move")
    func captureSoundOnCapture() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.pendingSoundEffect == .capture)
    }

    @Test("pendingSoundEffect is .gameOver when game ends")
    func gameOverSound() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.defender, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let move = Move(fromRow: 0, fromCol: 1, toRow: 0, toCol: 0)
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.pendingSoundEffect == .gameOver)
    }

    @Test("capturedSquares cleared on newGame")
    func newGameClearsCapturedSquares() {
        let state = GameState()
        let afterNew = gameReducer(state: state, action: GameAction.newGame)
        #expect(afterNew.capturedSquares.isEmpty)
    }

    @Test("pendingSoundEffect is .move on non-capture move")
    func moveSoundOnNonCapture() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let newState = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(newState.pendingSoundEffect == .move)
    }

    @Test("pendingSoundEffect is .select when piece selected")
    func selectSoundOnPieceSelect() {
        let state = GameState()
        let newState = gameReducer(state: state, action: GameAction.selectSquare(row: 0, col: 3))
        #expect(newState.pendingSoundEffect == .select)
    }

    @Test("pendingSoundEffect is nil when selecting empty square")
    func noSoundOnEmptySelect() {
        let state = GameState()
        let newState = gameReducer(state: state, action: GameAction.selectSquare(row: 2, col: 2))
        #expect(newState.pendingSoundEffect == nil)
    }

    @Test("undo clears pendingSoundEffect")
    func undoClearsPendingSound() {
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)
        #expect(afterUndo.pendingSoundEffect == nil)
    }
}
