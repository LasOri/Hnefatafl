import Testing
@testable import Hnefatafl

@Suite("KingEscapePlan Tests")
struct KingEscapePlanTests {

    @Test("king near corner has escape plan")
    func nearCorner() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .build()
        let plan = KingEscapePlan.compute(position: pos)
        #expect(plan != nil)
        #expect(!plan!.moves.isEmpty)
    }

    @Test("king on corner has zero-move plan")
    func onCorner() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 0)
            .build()
        let plan = KingEscapePlan.compute(position: pos)
        #expect(plan != nil)
        #expect(plan!.moves.isEmpty)
    }

    @Test("blocked king has no plan")
    func blocked() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 5, col: 4)
            .place(.attacker, row: 5, col: 6)
            .place(.attacker, row: 4, col: 5)
            .place(.attacker, row: 6, col: 5)
            .build()
        let plan = KingEscapePlan.compute(position: pos)
        #expect(plan == nil)
    }

    @Test("plan target is a corner")
    func targetIsCorner() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .build()
        let plan = KingEscapePlan.compute(position: pos)!
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        #expect(corners.contains(where: { $0.0 == plan.targetRow && $0.1 == plan.targetCol }))
    }

    @Test("EscapePlanResult is Equatable")
    func equatable() {
        let a = EscapePlanResult(moves: [], targetRow: 0, targetCol: 0)
        let b = EscapePlanResult(moves: [], targetRow: 0, targetCol: 0)
        #expect(a == b)
    }

    @Test("king far from corners gets multi-step plan")
    func farFromCorner() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let plan = KingEscapePlan.compute(position: pos)
        #expect(plan != nil)
    }

    @Test("no king returns nil")
    func noKing() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let plan = KingEscapePlan.compute(position: pos)
        #expect(plan == nil)
    }
}
