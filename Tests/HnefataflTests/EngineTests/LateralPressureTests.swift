import Testing
@testable import Hnefatafl

@Suite("Lateral Pressure Tests")
struct LateralPressureTests {

    @Test("empty board has zero pressure")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(LateralPressure.leftPressure(position: pos) == 0)
        #expect(LateralPressure.rightPressure(position: pos) == 0)
        #expect(LateralPressure.totalLateral(position: pos) == 0)
    }

    @Test("attacker on left side counted as left pressure")
    func leftSideAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 2] = .attacker
        let pos = Position(cells: cells)
        #expect(LateralPressure.leftPressure(position: pos) == 1)
        #expect(LateralPressure.rightPressure(position: pos) == 0)
    }

    @Test("attacker on right side counted as right pressure")
    func rightSideAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 8] = .attacker
        let pos = Position(cells: cells)
        #expect(LateralPressure.rightPressure(position: pos) == 1)
        #expect(LateralPressure.leftPressure(position: pos) == 0)
    }

    @Test("attacker in center column excluded from both")
    func centerExcluded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(LateralPressure.totalLateral(position: pos) == 0)
    }

    @Test("total lateral sums left and right")
    func totalSums() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 1] = .attacker
        cells[3 * 11 + 9] = .attacker
        let pos = Position(cells: cells)
        #expect(LateralPressure.totalLateral(position: pos) == 2)
    }

    @Test("defenders not counted")
    func defendersIgnored() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 1] = .defender
        cells[5 * 11 + 9] = .defender
        let pos = Position(cells: cells)
        #expect(LateralPressure.totalLateral(position: pos) == 0)
    }

    @Test("start position has both left and right pressure")
    func startPositionBothSides() {
        let pos = Position.copenhagenStart()
        #expect(LateralPressure.leftPressure(position: pos) > 0)
        #expect(LateralPressure.rightPressure(position: pos) > 0)
    }
}
