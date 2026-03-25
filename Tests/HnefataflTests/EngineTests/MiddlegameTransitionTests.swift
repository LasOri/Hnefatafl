import Testing
@testable import Hnefatafl

@Suite("Middlegame Transition Tests")
struct MiddlegameTransitionTests {

    @Test("start position has zero transition score")
    func startPositionZero() {
        let pos = Position.copenhagenStart()
        #expect(MiddlegameTransition.transitionScore(position: pos) == 0)
    }

    @Test("start position has not transitioned")
    func startNotTransitioned() {
        let pos = Position.copenhagenStart()
        #expect(!MiddlegameTransition.hasTransitioned(position: pos))
    }

    @Test("fewer pieces increases transition score")
    func fewerPiecesIncrease() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        cells[1] = .defender
        let pos = Position(cells: cells)
        #expect(MiddlegameTransition.transitionScore(position: pos) > 0)
    }

    @Test("hasTransitioned true when score high enough")
    func transitionedWhenHigh() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let score = MiddlegameTransition.transitionScore(position: pos)
        #expect(MiddlegameTransition.hasTransitioned(position: pos) == (score >= 8))
    }

    @Test("empty board has high transition score")
    func emptyBoardHighScore() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(MiddlegameTransition.transitionScore(position: pos) > 0)
    }

    @Test("score increases as more pieces are captured")
    func scoreIncreasesWithCaptures() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[5 * 11 + 5] = .king
        for i in 0..<20 { cells1[i + 11] = .attacker }
        for i in 0..<10 { cells1[i + 44] = .defender }
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[5 * 11 + 5] = .king
        cells2[11] = .attacker
        let pos2 = Position(cells: cells2)

        #expect(MiddlegameTransition.transitionScore(position: pos2) > MiddlegameTransition.transitionScore(position: pos1))
    }
}
