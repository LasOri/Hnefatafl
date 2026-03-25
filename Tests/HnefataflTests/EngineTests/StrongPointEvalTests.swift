import Testing
@testable import Hnefatafl

@Suite("StrongPointEval Tests")
struct StrongPointEvalTests {

    @Test("empty board has no strong points")
    func emptyBoardNoStrongPoints() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let points = StrongPointEval.strongPoints(position: pos, player: .attacker)
        #expect(points.isEmpty)
    }

    @Test("strong point score matches strong points count")
    func scoreMatchesCount() {
        let pos = Position.copenhagenStart()
        let points = StrongPointEval.strongPoints(position: pos, player: .attacker)
        let score = StrongPointEval.strongPointScore(position: pos, player: .attacker)
        #expect(score == points.count)
    }

    @Test("square between two friendly pieces is strong point")
    func squareBetweenFriendlies() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let points = StrongPointEval.strongPoints(position: pos, player: .attacker)
        let hasMiddle = points.contains { $0.row == 5 && $0.col == 5 }
        #expect(hasMiddle)
    }

    @Test("square adjacent to enemy is not strong point")
    func adjacentEnemyNotStrong() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        let points = StrongPointEval.strongPoints(position: pos, player: .attacker)
        let hasMiddle = points.contains { $0.row == 5 && $0.col == 5 }
        #expect(!hasMiddle)
    }

    @Test("strong point coordinates are valid")
    func validCoordinates() {
        let pos = Position.copenhagenStart()
        let points = StrongPointEval.strongPoints(position: pos, player: .defender)
        for pt in points {
            #expect(pt.row >= 0 && pt.row < Position.boardSize)
            #expect(pt.col >= 0 && pt.col < Position.boardSize)
        }
    }

    @Test("strong point score is non-negative")
    func scoreNonNegative() {
        let pos = Position.copenhagenStart()
        let score = StrongPointEval.strongPointScore(position: pos, player: .attacker)
        #expect(score >= 0)
    }
}
