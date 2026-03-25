import Testing
@testable import Hnefatafl

@Suite("Move Animator Tests")
struct MoveAnimatorTests {

    @Test("single move produces one animation")
    func singleMoveOneAnimation() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let anims = MoveAnimator.animate(move: move)
        #expect(anims.count == 1)
        #expect(anims[0].fromRow == 0)
        #expect(anims[0].toCol == 5)
        #expect(anims[0].easing == .easeInOut)
    }

    @Test("captured pieces produce additional animations")
    func capturedPiecesAdditional() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 3)
        let anims = MoveAnimator.animate(move: move, captured: [(0, 1), (0, 2)])
        #expect(anims.count == 3)
        #expect(anims[1].easing == .easeOut)
        #expect(anims[2].easing == .easeOut)
    }

    @Test("duration scales with distance")
    func durationScalesWithDistance() {
        let short = MoveAnimator.animate(move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1))
        let long = MoveAnimator.animate(move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10))
        #expect(long[0].durationMs > short[0].durationMs)
    }

    @Test("capture animation has fixed 200ms duration")
    func captureFixedDuration() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 3)
        let anims = MoveAnimator.animate(move: move, captured: [(1, 1)])
        #expect(anims[1].durationMs == 200)
    }

    @Test("no captures produces only move animation")
    func noCapturesOnlyMove() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 8)
        let anims = MoveAnimator.animate(move: move, captured: [])
        #expect(anims.count == 1)
        #expect(anims[0].durationMs == 100 + 3 * 50)
    }
}
