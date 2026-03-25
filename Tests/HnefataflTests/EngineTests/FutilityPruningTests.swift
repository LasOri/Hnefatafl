import Testing
@testable import Hnefatafl

@Suite("FutilityPruning Tests")
struct FutilityPruningTests {

    @Test("prunes when eval far below alpha")
    func prunesWhenFarBelowAlpha() {
        let result = FutilityPruning.shouldPrune(staticEval: -1000, alpha: 100, depth: 1)
        #expect(result == true)
    }

    @Test("no prune when eval close to alpha")
    func noPruneWhenCloseToAlpha() {
        let result = FutilityPruning.shouldPrune(staticEval: 0, alpha: 100, depth: 1)
        #expect(result == false)
    }

    @Test("no prune at depth 3 or higher")
    func noPruneAtDepth3Plus() {
        let result = FutilityPruning.shouldPrune(staticEval: -10000, alpha: 100, depth: 3)
        #expect(result == false)
    }

    @Test("adjusted margin scales with depth")
    func adjustedMarginScalesWithDepth() {
        let margin1 = FutilityPruning.adjustedMargin(depth: 1)
        let margin2 = FutilityPruning.adjustedMargin(depth: 2)
        #expect(margin2 > margin1)
        #expect(margin1 == 200)
        #expect(margin2 == 400)
    }

    @Test("no prune when eval equals alpha")
    func noPruneWhenEvalEqualsAlpha() {
        let alpha = 100
        let eval = alpha - FutilityPruning.margin * 1
        let result = FutilityPruning.shouldPrune(staticEval: eval, alpha: alpha, depth: 1)
        #expect(result == false)
    }
}
