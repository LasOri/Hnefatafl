import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Announcement Tests")
struct AnnouncementTests {

    @Test("announcement nil initially")
    func nilInitially() {
        let state = GameState()
        #expect(state.announcement == nil)
    }

    @Test("announcement set after makeMove")
    func setAfterMakeMove() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let after = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(after.announcement != nil)
    }

    @Test("announcement describes move coordinates")
    func describesMoveCoordinates() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let after = gameReducer(state: state, action: GameAction.makeMove(move))
        let announcement = after.announcement!
        let fromCol = Position.columnLetter(move.fromCol)
        let toCol = Position.columnLetter(move.toCol)
        #expect(announcement.contains(fromCol))
        #expect(announcement.contains(toCol))
    }

    @Test("announcement mentions capture when captures occur")
    func mentionsCaptureOnCapture() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let captureMove = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let after = gameReducer(state: state, action: GameAction.makeMove(captureMove))
        #expect(after.announcement?.lowercased().contains("capture") == true)
    }

    @Test("announcement cleared on selectSquare")
    func clearedOnSelectSquare() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(afterMove.announcement != nil)
        let afterSelect = gameReducer(state: afterMove, action: GameAction.selectSquare(row: 0, col: 3))
        #expect(afterSelect.announcement == nil)
    }

    @Test("announcement cleared on newGame")
    func clearedOnNewGame() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let afterNew = gameReducer(state: afterMove, action: GameAction.newGame)
        #expect(afterNew.announcement == nil)
    }

    @Test("AppComponent renders aria-live div")
    func rendersAriaLiveDiv() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let nodes = AppComponent.render(state: afterMove)
        let rendered = render(nodes)
        let liveRegion = rendered.findAll(tag: "div").first(where: { $0.attr("aria-live") == "assertive" })
        #expect(liveRegion != nil)
    }

    @Test("aria-live div contains announcement text")
    func ariaLiveDivContainsText() {
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        let nodes = AppComponent.render(state: afterMove)
        let rendered = render(nodes)
        #expect(rendered.findByText(afterMove.announcement!) != nil)
    }
}
