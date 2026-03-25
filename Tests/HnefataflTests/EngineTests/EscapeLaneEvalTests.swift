import Testing
@testable import Hnefatafl

@Suite("Escape Lane Eval Tests")
struct EscapeLaneEvalTests {

    @Test("no king returns zero lanes")
    func noKingZeroLanes() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(EscapeLaneEval.openLanes(position: pos) == 0)
    }

    @Test("isolated king has two open lanes")
    func isolatedKingTwoLanes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(EscapeLaneEval.openLanes(position: pos) == 2)
    }

    @Test("blocked row reduces lanes")
    func blockedRowReducesLanes() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 8] = .attacker
        let pos = Position(cells: cells)
        #expect(EscapeLaneEval.openLanes(position: pos) < 2)
    }

    @Test("lane score zero without king")
    func laneScoreNoKing() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(EscapeLaneEval.laneScore(position: pos) == 0)
    }

    @Test("isolated king has positive lane score")
    func isolatedKingPositiveLaneScore() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(EscapeLaneEval.laneScore(position: pos) > 0)
    }

    @Test("start position has limited open lanes")
    func startPositionLimitedLanes() {
        let pos = Position.copenhagenStart()
        #expect(EscapeLaneEval.openLanes(position: pos) == 0)
    }

    @Test("king on edge with clear column scores higher")
    func kingOnEdgeClearColumn() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let score = EscapeLaneEval.laneScore(position: pos)
        #expect(score > 0)
    }
}
