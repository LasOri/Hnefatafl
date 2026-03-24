import Testing
@testable import Hnefatafl

@Suite("Move Hint Tests")
struct MoveHintTests {

    @Test("HintEngine returns a legal move for starting position")
    func returnsLegalMove() {
        let game = Game()
        let hint = HintEngine.bestMove(for: game)
        #expect(hint != nil)
        let allMoves = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(allMoves.contains(hint!))
    }

    @Test("HintEngine returns nil when game is over")
    func nilWhenGameOver() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        #expect(game.status != .inProgress)
        let hint = HintEngine.bestMove(for: game)
        #expect(hint == nil)
    }

    @Test("hintMove defaults to nil")
    func defaultsToNil() {
        let state = GameState()
        #expect(state.hintMove == nil)
    }

    @Test("requestHint sets hintMove")
    func setsHintMove() {
        let state = GameState()
        let hinted = gameReducer(state: state, action: GameAction.requestHint)
        #expect(hinted.hintMove != nil)
    }

    @Test("making a move clears hintMove")
    func moveClearsHint() {
        let state = GameState()
        let hinted = gameReducer(state: state, action: GameAction.requestHint)
        #expect(hinted.hintMove != nil)
        let move = hinted.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: hinted, action: GameAction.makeMove(move))
        #expect(afterMove.hintMove == nil)
    }

    @Test("EventWiring maps request-hint")
    func eventWiring() {
        let action = EventWiring.actionForButton("request-hint")
        #expect(action != nil)
        if case .requestHint = action {} else {
            Issue.record("Expected .requestHint")
        }
    }

    @Test("HintEngine uses depth 1 for fast hints")
    func usesShallowDepth() {
        let game = Game()
        let hint = HintEngine.bestMove(for: game, depth: 1)
        #expect(hint != nil)
    }

    @Test("hint for same position is deterministic")
    func deterministic() {
        let game = Game()
        let hint1 = HintEngine.bestMove(for: game)
        let hint2 = HintEngine.bestMove(for: game)
        #expect(hint1 == hint2)
    }
}
