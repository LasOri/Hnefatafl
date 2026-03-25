import Testing
@testable import Hnefatafl

@Suite("Null Move Pruning Tests")
struct NullMovePruningTests {

    @Test("null move reduction depth")
    func reductionDepth() {
        let reduction = NullMovePruning.reduction(depth: 6)
        #expect(reduction == 2)
    }

    @Test("no reduction at shallow depth")
    func noReductionShallow() {
        let reduction = NullMovePruning.reduction(depth: 2)
        #expect(reduction == 0)
    }

    @Test("should attempt null move at sufficient depth")
    func shouldAttempt() {
        #expect(NullMovePruning.shouldAttempt(depth: 4, inCheck: false))
    }

    @Test("should not attempt when in check")
    func noAttemptInCheck() {
        #expect(!NullMovePruning.shouldAttempt(depth: 4, inCheck: true))
    }

    @Test("should not attempt at depth 1")
    func noAttemptDepthOne() {
        #expect(!NullMovePruning.shouldAttempt(depth: 1, inCheck: false))
    }

    @Test("minimum depth threshold is 3")
    func minimumDepth() {
        #expect(NullMovePruning.minimumDepth == 3)
    }

    @Test("reduction does not exceed depth minus 1")
    func reductionCapped() {
        let reduction = NullMovePruning.reduction(depth: 3)
        #expect(reduction < 3)
    }

    @Test("higher depth gives same or larger reduction")
    func deeperReduction() {
        let shallow = NullMovePruning.reduction(depth: 4)
        let deep = NullMovePruning.reduction(depth: 8)
        #expect(deep >= shallow)
    }
}
