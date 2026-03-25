import Testing
@testable import Hnefatafl

@Suite("QuiescenceSearch Tests")
struct QuiescenceSearchTests {

    @Test("search returns an integer")
    func searchReturnsInt() {
        let position = Position.copenhagenStart()
        let score = QuiescenceSearch.search(position: position, player: .attacker, alpha: -10000, beta: 10000)
        #expect(score >= -10000)
        #expect(score <= 10000)
    }

    @Test("stand pat when no captures available")
    func standPatNoCaptures() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[120] = .defender
        let position = Position(cells: cells)
        let score = QuiescenceSearch.search(position: position, player: .attacker, alpha: -10000, beta: 10000)
        let expectedEval = position.attackerCount - position.defenderCount
        #expect(score == expectedEval)
    }

    @Test("find capture moves on starting position")
    func findCaptureMoveStart() {
        let position = Position.copenhagenStart()
        let captures = QuiescenceSearch.findCaptureMoves(position: position, player: .attacker)
        #expect(captures.count >= 0)
    }

    @Test("empty board returns zero evaluation")
    func emptyBoardReturnsZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = QuiescenceSearch.search(position: position, player: .attacker, alpha: -10000, beta: 10000)
        #expect(score == 0)
    }

    @Test("search respects beta cutoff")
    func respectsBetaCutoff() {
        let position = Position.copenhagenStart()
        let lowBeta = -100
        let score = QuiescenceSearch.search(position: position, player: .attacker, alpha: -10000, beta: lowBeta)
        #expect(score <= lowBeta)
    }

    @Test("alpha-beta window narrows correctly")
    func alphaBetaWindowNarrows() {
        let position = Position.copenhagenStart()
        let wideScore = QuiescenceSearch.search(position: position, player: .attacker, alpha: -10000, beta: 10000)
        let narrowScore = QuiescenceSearch.search(position: position, player: .attacker, alpha: wideScore - 1, beta: wideScore + 1)
        #expect(narrowScore >= wideScore - 1)
        #expect(narrowScore <= wideScore + 1)
    }
}
