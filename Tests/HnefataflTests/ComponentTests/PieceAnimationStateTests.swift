import Testing
@testable import Hnefatafl

@Suite("PieceAnimationState Tests")
struct PieceAnimationStateTests {

    @Test("idle state is not animating")
    func idleNotAnimating() {
        let state = PieceAnimationState.idle
        #expect(state.isAnimating == false)
    }

    @Test("idle state has nil piece")
    func idleNilPiece() {
        let state = PieceAnimationState.idle
        #expect(state.animatingPiece == nil)
    }

    @Test("active animation stores piece")
    func activeAnimation() {
        let state = PieceAnimationState(
            isAnimating: true,
            animatingPiece: .attacker,
            fromRow: 0, fromCol: 3,
            toRow: 5, toCol: 3
        )
        #expect(state.isAnimating == true)
        #expect(state.animatingPiece == .attacker)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = PieceAnimationState.idle
        let b = PieceAnimationState.idle
        #expect(a == b)
    }

    @Test("inequal when different animating flag")
    func inequalAnimating() {
        let a = PieceAnimationState.idle
        let b = PieceAnimationState(
            isAnimating: true,
            animatingPiece: nil,
            fromRow: 0, fromCol: 0,
            toRow: 0, toCol: 0
        )
        #expect(a != b)
    }

    @Test("king animation stores correctly")
    func kingAnimation() {
        let state = PieceAnimationState(
            isAnimating: true,
            animatingPiece: .king,
            fromRow: 5, fromCol: 5,
            toRow: 0, toCol: 0
        )
        #expect(state.animatingPiece == .king)
        #expect(state.fromRow == 5)
        #expect(state.toRow == 0)
    }
}
