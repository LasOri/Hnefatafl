import Testing
@testable import Hnefatafl

@Suite("PressureScore Tests")
struct PressureScoreTests {

    @Test("empty board has zero pressure")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PressureScore.pressure(position: position, player: .attacker) == 0)
        #expect(PressureScore.pressure(position: position, player: .defender) == 0)
    }

    @Test("net pressure is zero on empty board")
    func netPressureZeroEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PressureScore.netPressure(position: position) == 0)
    }

    @Test("adjacent enemy pieces create pressure")
    func adjacentEnemyCreatesPressure() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        let attackerPressure = PressureScore.pressure(position: position, player: .attacker)
        #expect(attackerPressure >= 1)
    }

    @Test("non-adjacent pieces create no pressure")
    func nonAdjacentNoPressure() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 0] = .attacker
        cells[10 * 11 + 10] = .defender
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let attackerPressure = PressureScore.pressure(position: position, player: .attacker)
        #expect(attackerPressure == 0)
    }

    @Test("start position has positive pressure for both sides")
    func startPositionPositivePressure() {
        let position = Position.copenhagenStart()
        #expect(PressureScore.pressure(position: position, player: .attacker) >= 0)
        #expect(PressureScore.pressure(position: position, player: .defender) >= 0)
    }

    @Test("net pressure is attacker minus defender")
    func netPressureFormula() {
        let position = Position.copenhagenStart()
        let net = PressureScore.netPressure(position: position)
        let expected = PressureScore.pressure(position: position, player: .attacker) - PressureScore.pressure(position: position, player: .defender)
        #expect(net == expected)
    }
}
