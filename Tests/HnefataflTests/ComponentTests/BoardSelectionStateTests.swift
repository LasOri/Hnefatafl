import Testing
@testable import Hnefatafl

@Suite("BoardSelectionState Tests")
struct BoardSelectionStateTests {
    @Test("Initial state has zero count")
    func initialCount() {
        let state = BoardSelectionState(selectedSquares: [], maxSelections: 3)
        #expect(state.count == 0)
        #expect(state.isFull == false)
    }

    @Test("Toggle adds a square")
    func toggleAdds() {
        var state = BoardSelectionState(selectedSquares: [], maxSelections: 3)
        state.toggle(row: 2, col: 3)
        #expect(state.count == 1)
    }

    @Test("Toggle removes existing square")
    func toggleRemoves() {
        var state = BoardSelectionState(selectedSquares: [(row: 2, col: 3)], maxSelections: 3)
        state.toggle(row: 2, col: 3)
        #expect(state.count == 0)
    }

    @Test("Cannot exceed max selections")
    func maxSelections() {
        var state = BoardSelectionState(selectedSquares: [(row: 0, col: 0), (row: 1, col: 1)], maxSelections: 2)
        #expect(state.isFull == true)
        state.toggle(row: 2, col: 2)
        #expect(state.count == 2)
    }

    @Test("Is full when at max")
    func isFull() {
        let state = BoardSelectionState(selectedSquares: [(row: 0, col: 0), (row: 1, col: 1), (row: 2, col: 2)], maxSelections: 3)
        #expect(state.isFull == true)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = BoardSelectionState(selectedSquares: [(row: 1, col: 2)], maxSelections: 5)
        let b = BoardSelectionState(selectedSquares: [(row: 1, col: 2)], maxSelections: 5)
        #expect(a == b)
    }
}
