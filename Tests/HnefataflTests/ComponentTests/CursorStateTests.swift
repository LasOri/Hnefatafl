import Testing
@testable import Hnefatafl

@Suite("Cursor State Tests")
struct CursorStateTests {

    @Test("none preset has no hover")
    func noneNoHover() {
        let state = CursorState.none
        #expect(!state.hasHover)
        #expect(state.hoveredRow == nil)
        #expect(state.hoveredCol == nil)
    }

    @Test("none preset is not over piece")
    func noneNotOverPiece() {
        #expect(!CursorState.none.isOverPiece)
    }

    @Test("has hover when both row and col set")
    func hasHoverBothSet() {
        let state = CursorState(hoveredRow: 3, hoveredCol: 5, isOverPiece: false)
        #expect(state.hasHover)
    }

    @Test("no hover when only row set")
    func noHoverOnlyRow() {
        let state = CursorState(hoveredRow: 3, hoveredCol: nil, isOverPiece: false)
        #expect(!state.hasHover)
    }

    @Test("equatable works for identical states")
    func equatable() {
        let a = CursorState(hoveredRow: 2, hoveredCol: 3, isOverPiece: true)
        let b = CursorState(hoveredRow: 2, hoveredCol: 3, isOverPiece: true)
        #expect(a == b)
    }

    @Test("different isOverPiece values are not equal")
    func differentPieceState() {
        let a = CursorState(hoveredRow: 2, hoveredCol: 3, isOverPiece: true)
        let b = CursorState(hoveredRow: 2, hoveredCol: 3, isOverPiece: false)
        #expect(a != b)
    }

    @Test("no hover when only col set")
    func noHoverOnlyCol() {
        let state = CursorState(hoveredRow: nil, hoveredCol: 5, isOverPiece: false)
        #expect(!state.hasHover)
    }
}
