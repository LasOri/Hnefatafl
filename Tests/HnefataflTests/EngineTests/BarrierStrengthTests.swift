import Testing
@testable import Hnefatafl

@Suite("BarrierStrength Tests")
struct BarrierStrengthTests {

    @Test("empty board returns zero strength")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let strength = BarrierStrength.evaluate(position: pos)
        #expect(strength == 0)
    }

    @Test("empty board has four gaps")
    func emptyBoardFourGaps() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let gaps = BarrierStrength.barrierGaps(position: pos)
        #expect(gaps == 4)
    }

    @Test("king surrounded by attackers has high strength")
    func surroundedKingHighStrength() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let strength = BarrierStrength.evaluate(position: pos)
        #expect(strength >= 4)
    }

    @Test("king surrounded has zero gaps")
    func surroundedKingZeroGaps() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[6 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let gaps = BarrierStrength.barrierGaps(position: pos)
        #expect(gaps == 0)
    }

    @Test("attacker on one side means three gaps")
    func oneSideAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 7] = .attacker
        let pos = Position(cells: cells)
        let gaps = BarrierStrength.barrierGaps(position: pos)
        #expect(gaps == 3)
    }

    @Test("start position has nonzero strength")
    func startPositionNonzero() {
        let pos = Position.copenhagenStart()
        let strength = BarrierStrength.evaluate(position: pos)
        #expect(strength > 0)
    }
}
