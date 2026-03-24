import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Board Flip Tests")
struct BoardFlipTests {

    @Test("boardFlipped defaults to false")
    func defaultsToFalse() {
        let state = GameState()
        #expect(state.boardFlipped == false)
    }

    @Test("flipBoard toggles boardFlipped")
    func togglesFlipped() {
        let state = GameState()
        let flipped = gameReducer(state: state, action: GameAction.flipBoard)
        #expect(flipped.boardFlipped == true)
        let unflipped = gameReducer(state: flipped, action: GameAction.flipBoard)
        #expect(unflipped.boardFlipped == false)
    }

    @Test("boardFlipped preserved through makeMove")
    func preservedThroughMakeMove() {
        let flipped = gameReducer(state: GameState(), action: GameAction.flipBoard)
        let move = flipped.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: flipped, action: GameAction.makeMove(move))
        #expect(afterMove.boardFlipped == true)
    }

    @Test("boardFlipped preserved through newGame")
    func preservedThroughNewGame() {
        let flipped = gameReducer(state: GameState(), action: GameAction.flipBoard)
        let afterNew = gameReducer(state: flipped, action: GameAction.newGame)
        #expect(afterNew.boardFlipped == true)
    }

    @Test("EventWiring maps flip-board action")
    func eventWiringMaps() {
        let action = EventWiring.actionForButton("flip-board")
        #expect(action != nil)
        if case .flipBoard = action {} else {
            Issue.record("Expected .flipBoard")
        }
    }

    @Test("BoardFlipTransform flips row coordinate")
    func flipsRow() {
        #expect(BoardFlipTransform.displayRow(row: 0, flipped: true) == 10)
        #expect(BoardFlipTransform.displayRow(row: 10, flipped: true) == 0)
        #expect(BoardFlipTransform.displayRow(row: 5, flipped: false) == 5)
    }

    @Test("BoardFlipTransform flips col coordinate")
    func flipsCol() {
        #expect(BoardFlipTransform.displayCol(col: 0, flipped: true) == 10)
        #expect(BoardFlipTransform.displayCol(col: 10, flipped: true) == 0)
        #expect(BoardFlipTransform.displayCol(col: 3, flipped: false) == 3)
    }

    @Test("AppComponent renders flip button")
    func rendersFlipButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let btn = rendered.findAll(tag: "button").first(where: { $0.attr("data-action") == "flip-board" })
        #expect(btn != nil)
    }
}
