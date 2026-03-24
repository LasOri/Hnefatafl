import Testing
@testable import Hnefatafl

@Suite("Evaluation Weight Tests")
struct EvalWeightTests {

    @Test("default weights sum to 100")
    func defaultWeightsSum() {
        let weights = EvalWeights()
        let sum = weights.material + weights.mobility + weights.kingSafety + weights.territory + weights.position
        #expect(sum == 100)
    }

    @Test("material weight is dominant")
    func materialDominant() {
        let weights = EvalWeights()
        #expect(weights.material >= weights.mobility)
        #expect(weights.material >= weights.kingSafety)
    }

    @Test("weighted score applies weights")
    func weightedScore() {
        let weights = EvalWeights()
        let score = weights.apply(material: 10, mobility: 5, kingSafety: 3, territory: 2, position: 1)
        #expect(score > 0)
    }

    @Test("zero inputs produce zero score")
    func zeroScore() {
        let weights = EvalWeights()
        let score = weights.apply(material: 0, mobility: 0, kingSafety: 0, territory: 0, position: 0)
        #expect(score == 0)
    }

    @Test("aggressive preset favors material")
    func aggressivePreset() {
        let weights = EvalWeights.aggressive
        #expect(weights.material > EvalWeights().material)
    }

    @Test("defensive preset favors kingSafety")
    func defensivePreset() {
        let weights = EvalWeights.defensive
        #expect(weights.kingSafety > EvalWeights().kingSafety)
    }

    @Test("EvalWeights is Equatable")
    func equatable() {
        let a = EvalWeights()
        let b = EvalWeights()
        #expect(a == b)
    }

    @Test("custom weights")
    func customWeights() {
        let w = EvalWeights(material: 50, mobility: 20, kingSafety: 15, territory: 10, position: 5)
        #expect(w.material == 50)
        #expect(w.position == 5)
    }
}
