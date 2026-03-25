import Testing
@testable import Hnefatafl

@Suite("StrategicPlan Tests")
struct StrategicPlanTests {

    @Test("attacker suggest plan returns valid type")
    func attackerPlanValid() {
        let position = Position.copenhagenStart()
        let plan = StrategicPlan.suggestPlan(position: position, player: .attacker)
        let validPlans: [PlanType] = [.kingHunt, .cornerBlock, .materialGain, .consolidate]
        #expect(validPlans.contains(plan))
    }

    @Test("defender suggest plan returns valid type")
    func defenderPlanValid() {
        let position = Position.copenhagenStart()
        let plan = StrategicPlan.suggestPlan(position: position, player: .defender)
        let validPlans: [PlanType] = [.kingHunt, .cornerBlock, .materialGain, .consolidate]
        #expect(validPlans.contains(plan))
    }

    @Test("empty board yields consolidate for attacker")
    func emptyBoardConsolidates() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let plan = StrategicPlan.suggestPlan(position: position, player: .attacker)
        #expect(plan == .consolidate)
    }

    @Test("PlanType raw values are correct")
    func planTypeRawValues() {
        #expect(PlanType.kingHunt.rawValue == "kingHunt")
        #expect(PlanType.cornerBlock.rawValue == "cornerBlock")
        #expect(PlanType.materialGain.rawValue == "materialGain")
        #expect(PlanType.consolidate.rawValue == "consolidate")
    }

    @Test("king near corner triggers cornerBlock for attacker")
    func kingNearCornerTriggersCornerBlock() {
        let position = emptyBoard()
            .placing(.king, row: 1, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .build()
        let plan = StrategicPlan.suggestPlan(position: position, player: .attacker)
        #expect(plan == .cornerBlock)
    }

    @Test("PlanType conforms to Equatable")
    func planTypeEquatable() {
        let a = PlanType.kingHunt
        let b = PlanType.kingHunt
        #expect(a == b)
        #expect(PlanType.kingHunt != PlanType.consolidate)
    }
}
