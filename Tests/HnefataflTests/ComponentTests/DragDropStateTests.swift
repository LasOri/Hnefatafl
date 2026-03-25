import Testing
@testable import Hnefatafl

@Suite("Drag Drop State Tests")
struct DragDropStateTests {

    @Test("idle state has no dragging")
    func idleNotDragging() {
        let state = DragDropState.idle
        #expect(!state.isDragging)
        #expect(state.sourceRow == nil)
        #expect(state.sourceCol == nil)
    }

    @Test("idle state is not a valid drag")
    func idleNotValid() {
        #expect(!DragDropState.idle.isValidDrag)
    }

    @Test("valid drag requires all coordinates")
    func validDragAllCoords() {
        let state = DragDropState(
            isDragging: true,
            sourceRow: 3,
            sourceCol: 4,
            currentRow: 5,
            currentCol: 4
        )
        #expect(state.isValidDrag)
    }

    @Test("missing current position is not valid")
    func missingCurrentNotValid() {
        let state = DragDropState(
            isDragging: true,
            sourceRow: 3,
            sourceCol: 4,
            currentRow: nil,
            currentCol: nil
        )
        #expect(!state.isValidDrag)
    }

    @Test("equatable works for identical states")
    func equatable() {
        let a = DragDropState(isDragging: true, sourceRow: 1, sourceCol: 2, currentRow: 3, currentCol: 4)
        let b = DragDropState(isDragging: true, sourceRow: 1, sourceCol: 2, currentRow: 3, currentCol: 4)
        #expect(a == b)
    }

    @Test("different states are not equal")
    func notEqual() {
        let a = DragDropState(isDragging: true, sourceRow: 1, sourceCol: 2, currentRow: 3, currentCol: 4)
        let b = DragDropState(isDragging: false, sourceRow: 1, sourceCol: 2, currentRow: 3, currentCol: 4)
        #expect(a != b)
    }

    @Test("missing source col alone is not valid")
    func missingSourceColNotValid() {
        let state = DragDropState(
            isDragging: true,
            sourceRow: 3,
            sourceCol: nil,
            currentRow: 5,
            currentCol: 4
        )
        #expect(!state.isValidDrag)
    }
}
