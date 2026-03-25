import Testing
@testable import Hnefatafl

@Suite("Attacker Mobility Tests")
struct AttackerMobilityTests {

    @Test("empty board has zero mobility")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(AttackerMobility.totalMobility(position: pos) == 0)
    }

    @Test("empty board average mobility is zero")
    func emptyBoardAverageZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(AttackerMobility.averageMobility(position: pos) == 0)
    }

    @Test("start position has positive total mobility")
    func startPositionPositive() {
        let pos = Position.copenhagenStart()
        #expect(AttackerMobility.totalMobility(position: pos) > 0)
    }

    @Test("start position has positive average mobility")
    func startPositionAveragePositive() {
        let pos = Position.copenhagenStart()
        #expect(AttackerMobility.averageMobility(position: pos) > 0)
    }

    @Test("single attacker in center has many moves")
    func singleAttackerCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let total = AttackerMobility.totalMobility(position: pos)
        #expect(total > 0)
    }

    @Test("average equals total divided by count")
    func averageFormula() {
        let pos = Position.copenhagenStart()
        let total = AttackerMobility.totalMobility(position: pos)
        let avg = AttackerMobility.averageMobility(position: pos)
        let expected = Double(total) / Double(pos.attackerCount)
        #expect(avg == expected)
    }

    @Test("defenders not counted in attacker mobility")
    func defendersIgnored() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(AttackerMobility.totalMobility(position: pos) == 0)
    }
}
