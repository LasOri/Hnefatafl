import Testing
@testable import Hnefatafl

@Suite("Safety Margin Tests")
struct SafetyMarginTests {

    @Test("start position has a margin")
    func startPositionMargin() {
        let pos = Position.copenhagenStart()
        let margin = SafetyMargin.kingMargin(position: pos)
        #expect(margin > 0)
    }

    @Test("no king returns zero")
    func noKingReturnsZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let margin = SafetyMargin.kingMargin(position: pos)
        #expect(margin == 0)
    }

    @Test("lone king returns 100")
    func loneKingReturns100() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let margin = SafetyMargin.kingMargin(position: pos)
        #expect(margin == 100)
    }

    @Test("attacker adjacent gives margin of 10")
    func attackerAdjacentMargin10() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let margin = SafetyMargin.kingMargin(position: pos)
        #expect(margin == 10)
    }

    @Test("farther attacker yields higher margin")
    func fartherAttackerHigherMargin() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[5 * 11 + 5] = .king
        cells1[5 * 11 + 6] = .attacker
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .king
        cells2[5 * 11 + 9] = .attacker
        let pos2 = Position(cells: cells2)

        #expect(SafetyMargin.kingMargin(position: pos2) > SafetyMargin.kingMargin(position: pos1))
    }
}
