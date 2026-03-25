import Testing
@testable import Hnefatafl

@Suite("Incremental Eval Tests")
struct IncrementalEvalTests {

    @Test("initial state from starting position")
    func initialFromStart() {
        let position = Position.copenhagenStart()
        let state = IncrementalEval.initial(position: position, player: .attacker)
        let expectedMat = (position.attackerCount - position.defenderCount) * 100
        #expect(state.materialScore == expectedMat)
        #expect(state.mobilityEstimate == 0)
    }

    @Test("initial state for defender")
    func initialDefender() {
        let position = Position.copenhagenStart()
        let state = IncrementalEval.initial(position: position, player: .defender)
        let expectedMat = (position.defenderCount - position.attackerCount) * 100
        #expect(state.materialScore == expectedMat)
    }

    @Test("update adds captures and mobility")
    func updateAddsCaptures() {
        let state = IncrementalState(materialScore: 500, mobilityEstimate: 10)
        let updated = IncrementalEval.update(state: state, captures: 2, mobilityDelta: 5)
        #expect(updated.materialScore == 700)
        #expect(updated.mobilityEstimate == 15)
    }

    @Test("total is sum of material and mobility")
    func totalIsSum() {
        let state = IncrementalState(materialScore: 300, mobilityEstimate: 50)
        #expect(state.total == 350)
    }

    @Test("IncrementalState is equatable")
    func equatable() {
        let a = IncrementalState(materialScore: 100, mobilityEstimate: 20)
        let b = IncrementalState(materialScore: 100, mobilityEstimate: 20)
        #expect(a == b)
    }
}
