import Testing
@testable import Hnefatafl

@Suite("Coordinate Toggle Tests")
struct CoordinateToggleTests {

    @Test("showCoordinates defaults to true")
    func defaultTrue() {
        let state = GameState()
        #expect(state.showCoordinates == true)
    }

    @Test("toggleCoordinates flips state")
    func toggleFlips() {
        let state = GameState()
        let hidden = gameReducer(state: state, action: GameAction.toggleCoordinates)
        #expect(hidden.showCoordinates == false)
        let shown = gameReducer(state: hidden, action: GameAction.toggleCoordinates)
        #expect(shown.showCoordinates == true)
    }

    @Test("EventWiring maps toggle-coordinates")
    func eventWiring() {
        let action = EventWiring.actionForButton("toggle-coordinates")
        #expect(action != nil)
        if case .toggleCoordinates = action {} else {
            Issue.record("Expected .toggleCoordinates")
        }
    }

    @Test("CoordinateRenderer generates column labels A-K")
    func columnLabels() {
        let labels = CoordinateRenderer.columnLabels()
        #expect(labels.count == 11)
        #expect(labels[0] == "A")
        #expect(labels[10] == "K")
    }

    @Test("CoordinateRenderer generates row labels 1-11")
    func rowLabels() {
        let labels = CoordinateRenderer.rowLabels()
        #expect(labels.count == 11)
        #expect(labels[0] == "1")
        #expect(labels[10] == "11")
    }

    @Test("preserves through makeMove")
    func preservedThroughMove() {
        let state = gameReducer(state: GameState(), action: GameAction.toggleCoordinates)
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(afterMove.showCoordinates == false)
    }

    @Test("CoordinateRenderer label for flipped board")
    func flippedLabels() {
        let labels = CoordinateRenderer.columnLabels(flipped: true)
        #expect(labels[0] == "K")
        #expect(labels[10] == "A")
    }

    @Test("row labels flip correctly")
    func flippedRowLabels() {
        let labels = CoordinateRenderer.rowLabels(flipped: true)
        #expect(labels[0] == "11")
        #expect(labels[10] == "1")
    }
}
