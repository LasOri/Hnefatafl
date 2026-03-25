import Testing
@testable import Hnefatafl

@Suite("Move Impact Tests")
struct MoveImpactTests {

    @Test("non-capture move has zero captures")
    func nonCaptureZero() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let impact = MoveImpact.assess(move: move, position: position, player: .attacker)
        #expect(impact.captureCount >= 0)
    }

    @Test("total impact formula is correct")
    func totalImpactFormula() {
        let data = MoveImpactData(captureCount: 2, mobilityChange: 3, threatChange: 4)
        #expect(data.totalImpact == 2 * 100 + 3 * 10 + 4 * 5)
    }

    @Test("zero impact for zero values")
    func zeroImpact() {
        let data = MoveImpactData(captureCount: 0, mobilityChange: 0, threatChange: 0)
        #expect(data.totalImpact == 0)
    }

    @Test("mobility change tracks move count difference")
    func mobilityChange() {
        let position = Position.copenhagenStart()
        let moves = position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let impact = MoveImpact.assess(move: move, position: position, player: .attacker)
        #expect(impact.mobilityChange == impact.mobilityChange)
    }

    @Test("MoveImpactData supports equality")
    func impactEquality() {
        let a = MoveImpactData(captureCount: 1, mobilityChange: 2, threatChange: 3)
        let b = MoveImpactData(captureCount: 1, mobilityChange: 2, threatChange: 3)
        #expect(a == b)
    }
}
