import Testing
@testable import Hnefatafl

@Suite("Surround Score Tests")
struct SurroundScoreTests {

    @Test("start position king has non-zero surround score")
    func startPositionScore() {
        let position = Position.copenhagenStart()
        let score = SurroundScore.kingSurroundedness(position: position)
        #expect(score > 0)
    }

    @Test("no king returns zero")
    func noKingZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(SurroundScore.kingSurroundedness(position: position) == 0)
    }

    @Test("attacker adjacent to king scores 25")
    func attackerAdjacentScores25() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let score = SurroundScore.kingSurroundedness(position: position)
        #expect(score == 25)
    }

    @Test("king at edge gets higher score from out-of-bounds")
    func edgeIncreasesScore() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 5)
            .build()
        let score = SurroundScore.kingSurroundedness(position: position)
        #expect(score >= 25)
    }

    @Test("king fully surrounded by attackers scores maximum")
    func fullySurrounded() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .build()
        #expect(SurroundScore.kingSurroundedness(position: position) == 100)
    }
}
