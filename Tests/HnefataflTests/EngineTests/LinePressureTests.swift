import Testing
@testable import Hnefatafl

@Suite("Line Pressure Tests")
struct LinePressureTests {

    @Test("row pressure counts attackers in row")
    func rowPressureCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 0] = .attacker
        cells[3 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(LinePressure.rowPressure(position: position, targetRow: 3) == 30)
    }

    @Test("col pressure counts attackers in column")
    func colPressureCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 4] = .attacker
        cells[7 * 11 + 4] = .attacker
        cells[9 * 11 + 4] = .attacker
        let position = Position(cells: cells)
        #expect(LinePressure.colPressure(position: position, targetCol: 4) == 45)
    }

    @Test("total pressure on king sums row and column")
    func totalOnKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 0] = .attacker
        cells[0 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let total = LinePressure.totalPressureOnKing(position: position)
        #expect(total == 30)
    }

    @Test("no king returns 0")
    func noKingReturnsZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(LinePressure.totalPressureOnKing(position: position) == 0)
    }

    @Test("empty board has zero pressure")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(LinePressure.rowPressure(position: position, targetRow: 5) == 0)
        #expect(LinePressure.colPressure(position: position, targetCol: 5) == 0)
    }
}
