import Testing
@testable import Hnefatafl

@Suite("Penetration Depth Tests")
struct PenetrationDepthTests {

    @Test("empty board has zero max penetration")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(PenetrationDepth.maxPenetration(position: pos) == 0)
    }

    @Test("edge attacker has zero penetration")
    func edgeAttackerZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(PenetrationDepth.maxPenetration(position: pos) == 0)
    }

    @Test("center attacker has max penetration of 5")
    func centerAttackerFive() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(PenetrationDepth.maxPenetration(position: pos) == 5)
    }

    @Test("average penetration for single attacker equals max")
    func averageEqualsSingleMax() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .attacker
        let pos = Position(cells: cells)
        let max = PenetrationDepth.maxPenetration(position: pos)
        let avg = PenetrationDepth.averagePenetration(position: pos)
        #expect(avg == Double(max))
    }

    @Test("average zero for empty board")
    func averageZeroEmpty() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(PenetrationDepth.averagePenetration(position: pos) == 0)
    }

    @Test("mixed depth attackers produce correct average")
    func mixedDepthAverage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let avg = PenetrationDepth.averagePenetration(position: pos)
        #expect(avg == 2.5)
    }

    @Test("defenders not counted in penetration")
    func defendersIgnored() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(PenetrationDepth.maxPenetration(position: pos) == 0)
    }
}
