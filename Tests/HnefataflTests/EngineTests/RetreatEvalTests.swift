import Testing
@testable import Hnefatafl

@Suite("RetreatEval Tests")
struct RetreatEvalTests {

    @Test("empty board returns no retreat moves for attacker")
    func emptyBoardNoRetreats() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let moves = RetreatEval.retreatMoves(position: pos, player: .attacker)
        #expect(moves.isEmpty)
    }

    @Test("retreat score is zero on empty board")
    func emptyBoardScoreZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = RetreatEval.retreatScore(position: pos, player: .attacker)
        #expect(score == 0)
    }

    @Test("attacker moving toward edge is a retreat")
    func attackerEdgeRetreat() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let retreats = RetreatEval.retreatMoves(position: pos, player: .attacker)
        let movesToEdge = retreats.filter { $0.toRow < 3 }
        #expect(!movesToEdge.isEmpty)
    }

    @Test("defender retreat moves toward center")
    func defenderCenterRetreat() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[1 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        let retreats = RetreatEval.retreatMoves(position: pos, player: .defender)
        let movesToCenter = retreats.filter { $0.toRow > 1 }
        #expect(!movesToCenter.isEmpty)
    }

    @Test("retreat score is non-negative")
    func retreatScoreNonNegative() {
        let pos = Position.copenhagenStart()
        let score = RetreatEval.retreatScore(position: pos, player: .attacker)
        #expect(score >= 0)
    }

    @Test("start position has some retreat moves for attacker")
    func startPositionHasRetreats() {
        let pos = Position.copenhagenStart()
        let retreats = RetreatEval.retreatMoves(position: pos, player: .attacker)
        #expect(!retreats.isEmpty)
    }
}
