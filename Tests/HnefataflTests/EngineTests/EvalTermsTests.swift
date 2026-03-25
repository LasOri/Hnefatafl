import Testing
@testable import Hnefatafl

@Suite("EvalTerms Tests")
struct EvalTermsTests {

    @Test("breakdown has terms")
    func breakdownHasTerms() {
        let position = Position.copenhagenStart()
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        #expect(!breakdown.terms.isEmpty)
    }

    @Test("total sums weighted values")
    func totalSumsWeightedValues() {
        let position = Position.copenhagenStart()
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        let manualTotal = breakdown.terms.map(\.weighted).reduce(0, +)
        #expect(breakdown.total == manualTotal)
    }

    @Test("material term present")
    func materialTermPresent() {
        let position = Position.copenhagenStart()
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        let materialTerm = breakdown.terms.first(where: { $0.name == "material" })
        #expect(materialTerm != nil)
    }

    @Test("mobility term present")
    func mobilityTermPresent() {
        let position = Position.copenhagenStart()
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        let mobilityTerm = breakdown.terms.first(where: { $0.name == "mobility" })
        #expect(mobilityTerm != nil)
    }

    @Test("start position breakdown for attacker")
    func startPositionAttacker() {
        let position = Position.copenhagenStart()
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        let materialTerm = breakdown.terms.first(where: { $0.name == "material" })!
        #expect(materialTerm.value == position.attackerCount - position.defenderCount)
        #expect(materialTerm.weight == 100)
    }

    @Test("empty position breakdown")
    func emptyPositionBreakdown() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let breakdown = EvalTerms.breakdown(position: position, player: .attacker)
        let materialTerm = breakdown.terms.first(where: { $0.name == "material" })!
        #expect(materialTerm.value == 0)
        #expect(breakdown.total == 0)
    }
}
