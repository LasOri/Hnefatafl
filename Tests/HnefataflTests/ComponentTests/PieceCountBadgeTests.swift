import Testing
@testable import Hnefatafl

@Suite("PieceCountBadge Tests")
struct PieceCountBadgeTests {

    @Test("start position has correct counts")
    func startPositionCounts() {
        let badge = PieceCountBadge.from(position: Position.copenhagenStart())
        #expect(badge.attackerCount == 24)
        #expect(badge.defenderCount == 13)
        #expect(badge.kingAlive == true)
    }

    @Test("advantage shows Attackers plus when more attackers")
    func attackerAdvantage() {
        let badge = PieceCountBadge(attackerCount: 10, defenderCount: 5, kingAlive: true)
        #expect(badge.advantage == "Attackers +5")
    }

    @Test("advantage shows Defenders plus when more defenders")
    func defenderAdvantage() {
        let badge = PieceCountBadge(attackerCount: 3, defenderCount: 8, kingAlive: true)
        #expect(badge.advantage == "Defenders +5")
    }

    @Test("advantage shows Even when equal")
    func evenAdvantage() {
        let badge = PieceCountBadge(attackerCount: 7, defenderCount: 7, kingAlive: true)
        #expect(badge.advantage == "Even")
    }

    @Test("empty board has no king")
    func emptyBoardNoKing() {
        let badge = PieceCountBadge.from(position: Position(cells: Array(repeating: nil, count: 121)))
        #expect(badge.kingAlive == false)
        #expect(badge.attackerCount == 0)
        #expect(badge.defenderCount == 0)
    }

    @Test("equatable conformance works")
    func equatable() {
        let a = PieceCountBadge(attackerCount: 5, defenderCount: 3, kingAlive: true)
        let b = PieceCountBadge(attackerCount: 5, defenderCount: 3, kingAlive: true)
        #expect(a == b)
    }
}
