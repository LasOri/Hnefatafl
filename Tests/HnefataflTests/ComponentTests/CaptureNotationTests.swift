import Testing
@testable import Hnefatafl
import LINKER
import LINKERTesting

@Suite("Capture Notation Tests")
struct CaptureNotationTests {

    @Test("non-capture move shows dash separator")
    func nonCaptureDash() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 3)
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let nodes = MoveHistoryComponent.render(state: afterMove)
        let rendered = render(nodes)
        let text = rendered.findAll(tag: "li").first?.text ?? ""
        #expect(text.contains("-"))
        #expect(!text.contains("x"))
    }

    @Test("capture move shows x separator")
    func captureX() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let nodes = MoveHistoryComponent.render(state: afterMove)
        let rendered = render(nodes)
        let text = rendered.findAll(tag: "li").first?.text ?? ""
        #expect(text.contains("x"))
    }

    @Test("captureHistory tracks captures per move")
    func captureHistoryTracks() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let captureMove = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let afterCapture = gameReducer(state: state, action: GameAction.makeMove(captureMove))
        #expect(afterCapture.captureHistory == [true])
    }

    @Test("captureHistory tracks non-capture as false")
    func captureHistoryNonCapture() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 3)
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(afterMove.captureHistory == [false])
    }

    @Test("captureHistory cleared on newGame")
    func captureHistoryClearedOnNewGame() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterNew = gameReducer(state: afterMove, action: GameAction.newGame)
        #expect(afterNew.captureHistory.isEmpty)
    }

    @Test("captureHistory popped on undo")
    func captureHistoryPoppedOnUndo() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(!afterMove.captureHistory.isEmpty)
        let afterUndo = gameReducer(state: afterMove, action: GameAction.undo)
        #expect(afterUndo.captureHistory.isEmpty)
    }

    @Test("move history renders mixed captures and non-captures")
    func mixedNotation() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 3)
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 10, col: 10)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: []
        )
        let after1 = gameReducer(state: state, action: GameAction.makeMove(move1))
        #expect(after1.captureHistory == [false])
        let nodes = MoveHistoryComponent.render(state: after1)
        let rendered = render(nodes)
        let items = rendered.findAll(tag: "li")
        let firstText = items.first?.text ?? ""
        #expect(firstText.contains("-"))
    }
}
