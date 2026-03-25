import Testing
@testable import Hnefatafl

@Suite("MoveTransition Tests")
struct MoveTransitionTests {

    @Test("isComplete when progress is 1.0")
    func completeAtOne() {
        let t = MoveTransition(fromRow: 0, fromCol: 0, toRow: 5, toCol: 5, progress: 1.0)
        #expect(t.isComplete == true)
    }

    @Test("not complete when progress below 1.0")
    func notCompleteBelow() {
        let t = MoveTransition(fromRow: 0, fromCol: 0, toRow: 5, toCol: 5, progress: 0.5)
        #expect(t.isComplete == false)
    }

    @Test("currentRow at start is fromRow")
    func currentRowAtStart() {
        let t = MoveTransition(fromRow: 2, fromCol: 3, toRow: 8, toCol: 3, progress: 0.0)
        #expect(t.currentRow == 2.0)
    }

    @Test("currentCol at end is toCol")
    func currentColAtEnd() {
        let t = MoveTransition(fromRow: 0, fromCol: 2, toRow: 0, toCol: 9, progress: 1.0)
        #expect(t.currentCol == 9.0)
    }

    @Test("currentRow interpolates at midpoint")
    func interpolationMidpoint() {
        let t = MoveTransition(fromRow: 0, fromCol: 0, toRow: 10, toCol: 0, progress: 0.5)
        #expect(t.currentRow == 5.0)
    }

    @Test("MoveTransition conforms to Equatable")
    func equatableConformance() {
        let a = MoveTransition(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, progress: 0.5)
        let b = MoveTransition(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, progress: 0.5)
        #expect(a == b)
    }

    @Test("isComplete true for progress above 1.0")
    func completeAboveOne() {
        let t = MoveTransition(fromRow: 0, fromCol: 0, toRow: 5, toCol: 5, progress: 1.5)
        #expect(t.isComplete == true)
    }
}
