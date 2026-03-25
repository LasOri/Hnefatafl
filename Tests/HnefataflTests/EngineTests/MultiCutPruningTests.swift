import Testing
@testable import Hnefatafl

@Suite("Multi-Cut Pruning Tests")
struct MultiCutPruningTests {

    @Test("should prune at threshold")
    func shouldPruneAtThreshold() {
        #expect(MultiCutPruning.shouldPrune(cutoffCount: 3))
        #expect(MultiCutPruning.shouldPrune(cutoffCount: 5))
    }

    @Test("should not prune below threshold")
    func shouldNotPruneBelowThreshold() {
        #expect(!MultiCutPruning.shouldPrune(cutoffCount: 0))
        #expect(!MultiCutPruning.shouldPrune(cutoffCount: 2))
    }

    @Test("trial move count caps at total moves")
    func trialMoveCountCaps() {
        #expect(MultiCutPruning.trialMoveCount(totalMoves: 3) == 3)
        #expect(MultiCutPruning.trialMoveCount(totalMoves: 10) == 6)
        #expect(MultiCutPruning.trialMoveCount(totalMoves: 6) == 6)
    }

    @Test("cutoff ratio calculation")
    func cutoffRatioCalculation() {
        let ratio = MultiCutPruning.cutoffRatio(cutoffs: 3, trials: 6)
        #expect(abs(ratio - 0.5) < 0.001)
    }

    @Test("cutoff ratio with zero trials")
    func cutoffRatioZeroTrials() {
        let ratio = MultiCutPruning.cutoffRatio(cutoffs: 0, trials: 0)
        #expect(ratio == 0)
    }
}
