import Testing
@testable import Hnefatafl

@Suite("Numerical Advantage Tests")
struct NumericalAdvantageTests {

    @Test("empty board has zero global advantage")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(NumericalAdvantage.globalAdvantage(position: pos) == 0)
    }

    @Test("start position global advantage is attacker count minus defender count")
    func startPositionGlobal() {
        let pos = Position.copenhagenStart()
        let expected = pos.attackerCount - pos.defenderCount
        #expect(NumericalAdvantage.globalAdvantage(position: pos) == expected)
    }

    @Test("local advantage at empty area is zero")
    func localEmptyArea() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(NumericalAdvantage.localAdvantage(position: pos, row: 5, col: 5, radius: 2) == 0)
    }

    @Test("local advantage positive when more attackers")
    func localMoreAttackers() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[6 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(NumericalAdvantage.localAdvantage(position: pos, row: 5, col: 5, radius: 1) > 0)
    }

    @Test("local advantage negative when more defenders")
    func localMoreDefenders() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 6] = .defender
        cells[6 * 11 + 5] = .king
        cells[4 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(NumericalAdvantage.localAdvantage(position: pos, row: 5, col: 5, radius: 1) < 0)
    }

    @Test("radius zero counts only the target square")
    func radiusZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(NumericalAdvantage.localAdvantage(position: pos, row: 5, col: 5, radius: 0) == 1)
    }
}
