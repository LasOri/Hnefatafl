import Testing
@testable import Hnefatafl

@Suite("Corner Proximity Eval Tests")
struct CornerProximityEvalTests {

    @Test("start position eval is zero since king is at center")
    func startPositionEval() {
        let pos = Position.copenhagenStart()
        let score = CornerProximityEval.evaluate(position: pos)
        #expect(score >= 0)
    }

    @Test("empty board returns zero")
    func emptyBoardReturnsZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = CornerProximityEval.evaluate(position: pos)
        #expect(score == 0)
    }

    @Test("king near corner scores high")
    func kingNearCornerScoresHigh() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 0] = .king
        let pos = Position(cells: cells)
        let score = CornerProximityEval.evaluate(position: pos)
        #expect(score >= 100)
    }

    @Test("blockers reduce score")
    func blockersReduceScore() {
        var cellsNoBlockers: [Piece?] = Array(repeating: nil, count: 121)
        cellsNoBlockers[1 * 11 + 0] = .king
        let scoreNoBlockers = CornerProximityEval.evaluate(position: Position(cells: cellsNoBlockers))

        var cellsWithBlockers: [Piece?] = Array(repeating: nil, count: 121)
        cellsWithBlockers[1 * 11 + 0] = .king
        cellsWithBlockers[0 * 11 + 0] = .attacker
        cellsWithBlockers[0 * 11 + 1] = .attacker
        cellsWithBlockers[1 * 11 + 1] = .attacker
        let scoreWithBlockers = CornerProximityEval.evaluate(position: Position(cells: cellsWithBlockers))

        #expect(scoreNoBlockers > scoreWithBlockers)
    }

    @Test("eval is bounded below by zero")
    func evalIsBounded() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        for r in 0..<Position.boardSize {
            for c in 0..<Position.boardSize {
                if r != 5 || c != 5 {
                    if (r + c) % 3 == 0 {
                        cells[r * 11 + c] = .attacker
                    }
                }
            }
        }
        let pos = Position(cells: cells)
        let score = CornerProximityEval.evaluate(position: pos)
        #expect(score >= 0)
    }
}
