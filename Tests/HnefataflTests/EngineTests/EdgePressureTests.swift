import Testing
@testable import Hnefatafl

@Suite("EdgePressure Tests")
struct EdgePressureTests {

    @Test("empty board has zero edge pressure")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let total = EdgePressure.edgePressureTotal(position: pos, player: .attacker)
        #expect(total == 0)
    }

    @Test("piece on top edge gives max top pressure")
    func pieceOnTopEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let top = EdgePressure.topEdgePressure(position: pos, player: .attacker)
        #expect(top == 3)
    }

    @Test("piece far from top edge gives zero top pressure")
    func pieceFarFromTopEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let top = EdgePressure.topEdgePressure(position: pos, player: .attacker)
        #expect(top == 0)
    }

    @Test("total pressure sums all four edges")
    func totalSumsFourEdges() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        cells[10 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let total = EdgePressure.edgePressureTotal(position: pos, player: .attacker)
        #expect(total >= 6)
    }

    @Test("start position has nonzero attacker edge pressure")
    func startPositionNonzero() {
        let pos = Position.copenhagenStart()
        let total = EdgePressure.edgePressureTotal(position: pos, player: .attacker)
        #expect(total > 0)
    }

    @Test("defender pieces count for defender pressure")
    func defenderPressureCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .defender
        let pos = Position(cells: cells)
        let top = EdgePressure.topEdgePressure(position: pos, player: .defender)
        #expect(top > 0)
    }
}
