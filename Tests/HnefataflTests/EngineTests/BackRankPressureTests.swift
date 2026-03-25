import Testing
@testable import Hnefatafl

@Suite("Back Rank Pressure Tests")
struct BackRankPressureTests {

    @Test("start position has attacker back rank pieces")
    func startPositionAttacker() {
        let pos = Position.copenhagenStart()
        let pressure = BackRankPressure.evaluate(position: pos, player: .attacker)
        #expect(pressure > 0)
    }

    @Test("empty board returns zero pressure")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(BackRankPressure.evaluate(position: pos, player: .attacker) == 0)
    }

    @Test("piece on top row counts for back rank")
    func topRowCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(BackRankPressure.evaluate(position: pos, player: .attacker) == 1)
    }

    @Test("piece on bottom row counts for back rank")
    func bottomRowCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[10 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(BackRankPressure.evaluate(position: pos, player: .defender) == 1)
    }

    @Test("piece on left column counts for back rank")
    func leftColCounts() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 0] = .attacker
        let pos = Position(cells: cells)
        #expect(BackRankPressure.evaluate(position: pos, player: .attacker) == 1)
    }

    @Test("totalBackRankPieces sums both players")
    func totalSumsBoth() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        cells[10 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(BackRankPressure.totalBackRankPieces(position: pos) == 2)
    }

    @Test("center piece does not count as back rank")
    func centerNotBackRank() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(BackRankPressure.evaluate(position: pos, player: .attacker) == 0)
    }
}
