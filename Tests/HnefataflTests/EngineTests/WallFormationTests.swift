import Testing
@testable import Hnefatafl

@Suite("WallFormation Tests")
struct WallFormationTests {

    @Test("empty board has zero wall strength")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(WallFormation.evaluate(position: position) == 0)
    }

    @Test("evaluate sums all edge strengths")
    func evaluateSumsAll() {
        let position = Position.copenhagenStart()
        let total = WallFormation.evaluate(position: position)
        let sum = (0...3).map { WallFormation.wallStrength(position: position, edge: $0) }.reduce(0, +)
        #expect(total == sum)
    }

    @Test("start position top edge has attackers")
    func topEdgeAttackers() {
        let position = Position.copenhagenStart()
        let strength = WallFormation.wallStrength(position: position, edge: 0)
        #expect(strength == 5)
    }

    @Test("start position bottom edge has attackers")
    func bottomEdgeAttackers() {
        let position = Position.copenhagenStart()
        let strength = WallFormation.wallStrength(position: position, edge: 2)
        #expect(strength == 5)
    }

    @Test("start position left edge has attackers")
    func leftEdgeAttackers() {
        let position = Position.copenhagenStart()
        let strength = WallFormation.wallStrength(position: position, edge: 3)
        #expect(strength == 5)
    }

    @Test("start position right edge has attackers")
    func rightEdgeAttackers() {
        let position = Position.copenhagenStart()
        let strength = WallFormation.wallStrength(position: position, edge: 1)
        #expect(strength == 5)
    }

    @Test("invalid edge returns zero")
    func invalidEdgeZero() {
        let position = Position.copenhagenStart()
        #expect(WallFormation.wallStrength(position: position, edge: 5) == 0)
        #expect(WallFormation.wallStrength(position: position, edge: -1) == 0)
    }
}
