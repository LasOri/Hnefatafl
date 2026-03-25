import Testing
@testable import Hnefatafl

@Suite("Eval Scale Tests")
struct EvalScaleTests {

    @Test("normalize clamps to max range")
    func normalizeClamps() {
        #expect(EvalScale.normalize(rawScore: 5000) == 1000)
        #expect(EvalScale.normalize(rawScore: -5000) == -1000)
    }

    @Test("normalize passes through in-range values")
    func normalizePassesThrough() {
        #expect(EvalScale.normalize(rawScore: 500) == 500)
        #expect(EvalScale.normalize(rawScore: -200) == -200)
    }

    @Test("normalize with zero maxRange returns zero")
    func normalizeZeroRange() {
        #expect(EvalScale.normalize(rawScore: 100, maxRange: 0) == 0)
    }

    @Test("win probability at zero is 0.5")
    func winProbabilityAtZero() {
        let prob = EvalScale.toWinProbability(score: 0)
        #expect(abs(prob - 0.5) < 0.001)
    }

    @Test("win probability increases with positive score")
    func winProbabilityIncreases() {
        let low = EvalScale.toWinProbability(score: 100)
        let high = EvalScale.toWinProbability(score: 1000)
        #expect(high > low)
        #expect(high > 0.5)
    }

    @Test("isDecisive detects large scores")
    func isDecisive() {
        #expect(EvalScale.isDecisive(score: EvalScale.winScore))
        #expect(EvalScale.isDecisive(score: -EvalScale.winScore))
        #expect(!EvalScale.isDecisive(score: 100))
        #expect(!EvalScale.isDecisive(score: 0))
    }
}
