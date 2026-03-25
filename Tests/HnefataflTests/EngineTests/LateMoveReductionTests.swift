import Testing
@testable import Hnefatafl

@Suite("Late Move Reduction Tests")
struct LateMoveReductionTests {

    @Test("no reduction for first few moves")
    func noReductionEarly() {
        let reduction = LateMoveReduction.reduction(moveIndex: 0, depth: 4)
        #expect(reduction == 0)
    }

    @Test("reduction for later moves")
    func reductionLater() {
        let reduction = LateMoveReduction.reduction(moveIndex: 6, depth: 4)
        #expect(reduction > 0)
    }

    @Test("no reduction at shallow depth")
    func noReductionShallow() {
        let reduction = LateMoveReduction.reduction(moveIndex: 10, depth: 1)
        #expect(reduction == 0)
    }

    @Test("threshold is configurable")
    func threshold() {
        #expect(LateMoveReduction.moveThreshold >= 3)
    }

    @Test("minimum depth is 3")
    func minimumDepth() {
        #expect(LateMoveReduction.minimumDepth == 3)
    }

    @Test("reduction does not exceed 2")
    func reductionCapped() {
        let reduction = LateMoveReduction.reduction(moveIndex: 50, depth: 10)
        #expect(reduction <= 2)
    }

    @Test("should reduce checks correctly")
    func shouldReduce() {
        #expect(LateMoveReduction.shouldReduce(moveIndex: 10, depth: 5, isCapture: false))
        #expect(!LateMoveReduction.shouldReduce(moveIndex: 10, depth: 5, isCapture: true))
    }

    @Test("captures are never reduced")
    func capturesNotReduced() {
        #expect(!LateMoveReduction.shouldReduce(moveIndex: 20, depth: 8, isCapture: true))
    }
}
