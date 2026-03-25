import Testing
@testable import Hnefatafl

@Suite("Encirclement Score Tests")
struct EncirclementScoreTests {

    @Test("no king returns zero score")
    func noKing() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(EncirclementScore.score(position: position) == 0)
    }

    @Test("king alone with no attackers scores zero")
    func kingAloneNoAttackers() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(EncirclementScore.score(position: position) == 0)
    }

    @Test("one attacker in line of sight scores 12")
    func oneAttackerInSight() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 8)
            .build()
        let score = EncirclementScore.score(position: position)
        #expect(score == 12)
    }

    @Test("attackers on all four cardinal directions scores 48")
    func fourCardinalAttackers() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 10, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .placing(.attacker, row: 5, col: 10)
            .build()
        let score = EncirclementScore.score(position: position)
        #expect(score == 48)
    }

    @Test("starting position encirclement score is zero due to defender shield")
    func startingPositionScore() {
        let position = Position.copenhagenStart()
        let score = EncirclementScore.score(position: position)
        #expect(score == 0)
    }
}
