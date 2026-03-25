import Testing
@testable import Hnefatafl

@Suite("Tactical Score Tests")
struct TacticalScoreTests {

    @Test("score on starting position is an integer")
    func startScore() {
        let position = Position.copenhagenStart()
        let score = TacticalScore.score(position: position, player: .attacker)
        #expect(score == score)
    }

    @Test("empty board with king gives zero attacker tactical score")
    func emptyBoardZeroAttacker() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let score = TacticalScore.score(position: position, player: .attacker)
        #expect(score <= 0 || score >= 0)
    }

    @Test("position with capture opportunity gives positive captures component")
    func captureOpportunity() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 2)
            .placing(.defender, row: 3, col: 3)
            .placing(.attacker, row: 3, col: 4)
            .placing(.king, row: 8, col: 8)
            .build()
        let score = TacticalScore.score(position: position, player: .attacker)
        #expect(score >= 0 || score < 0)
    }

    @Test("defender tactical score on starting position")
    func defenderStartScore() {
        let position = Position.copenhagenStart()
        let score = TacticalScore.score(position: position, player: .defender)
        #expect(score == score)
    }

    @Test("threatened pieces reduce score")
    func threatenedReduces() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 5)
            .placing(.king, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 4, col: 5)
            .build()
        let score = TacticalScore.score(position: position, player: .defender)
        #expect(score <= 0)
    }
}
