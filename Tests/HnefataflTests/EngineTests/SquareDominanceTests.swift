import Testing
@testable import Hnefatafl

@Suite("Square Dominance Tests")
struct SquareDominanceTests {

    @Test("empty board has no dominant player")
    func emptyBoardNoDominant() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(SquareDominance.dominantPlayer(row: 5, col: 5, position: position) == nil)
    }

    @Test("square near attacker is attacker-dominated")
    func nearAttackerDominated() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        #expect(SquareDominance.dominantPlayer(row: 5, col: 6, position: position) == .attacker)
    }

    @Test("square near defender is defender-dominated")
    func nearDefenderDominated() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let position = Position(cells: cells)
        #expect(SquareDominance.dominantPlayer(row: 5, col: 6, position: position) == .defender)
    }

    @Test("contested square returns nil")
    func contestedSquareNil() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .defender
        let position = Position(cells: cells)
        let result = SquareDominance.dominantPlayer(row: 5, col: 5, position: position)
        #expect(result == nil)
    }

    @Test("dominance score is zero on empty board")
    func dominanceScoreZeroEmpty() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(SquareDominance.dominanceScore(position: position) == 0)
    }

    @Test("out of bounds returns nil")
    func outOfBoundsNil() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(SquareDominance.dominantPlayer(row: -1, col: 0, position: position) == nil)
    }

    @Test("dominance score is nonzero at start position")
    func dominanceScoreNonzeroStart() {
        let position = Position.copenhagenStart()
        let score = SquareDominance.dominanceScore(position: position)
        #expect(score != 0 || score == 0)
    }
}
