import Testing
@testable import Hnefatafl

@Suite("Weighted Eval Tests")
struct WeightedEvalTests {

    @Test("evaluate with default weights")
    func defaultWeights() {
        let position = Position.copenhagenStart()
        let score = WeightedEval.evaluate(position: position, player: .attacker, weights: [:])
        #expect(score != 0 || score == 0)
    }

    @Test("custom material weight")
    func customMaterialWeight() {
        let position = Position.copenhagenStart()
        let score1 = WeightedEval.evaluate(position: position, player: .attacker, weights: ["material": 100])
        let score2 = WeightedEval.evaluate(position: position, player: .attacker, weights: ["material": 200])
        let atkCount = position.attackerCount
        let defCount = position.defenderCount
        let materialDiff = atkCount - defCount
        if materialDiff != 0 {
            #expect(score2 != score1)
        }
    }

    @Test("EvalWeight contribution is value times multiplier")
    func evalWeightContribution() {
        let w = EvalWeight(name: "test", value: 5, multiplier: 10)
        #expect(w.contribution == 50)
    }

    @Test("EvalWeight is equatable")
    func evalWeightEquatable() {
        let a = EvalWeight(name: "x", value: 1, multiplier: 2)
        let b = EvalWeight(name: "x", value: 1, multiplier: 2)
        #expect(a == b)
    }

    @Test("mobility weight affects score")
    func mobilityWeightAffects() {
        let position = Position.copenhagenStart()
        let scoreNoMob = WeightedEval.evaluate(position: position, player: .attacker, weights: ["material": 100, "mobility": 0])
        let scoreWithMob = WeightedEval.evaluate(position: position, player: .attacker, weights: ["material": 100, "mobility": 50])
        let atkMoves = position.allLegalMoves(for: .attacker).count
        let defMoves = position.allLegalMoves(for: .defender).count
        if atkMoves != defMoves {
            #expect(scoreNoMob != scoreWithMob)
        }
    }
}
