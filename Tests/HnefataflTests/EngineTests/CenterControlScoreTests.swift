import Testing
@testable import Hnefatafl

@Suite("CenterControlScore Tests")
struct CenterControlScoreTests {

    @Test("empty board scores zero")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(CenterControlScore.score(position: position, player: .attacker) == 0)
    }

    @Test("start position defenders have center control")
    func startDefendersCenter() {
        let position = Position.copenhagenStart()
        let defScore = CenterControlScore.score(position: position, player: .defender)
        #expect(defScore > 0)
    }

    @Test("start position attackers have less center control")
    func startAttackersLessCenter() {
        let position = Position.copenhagenStart()
        let attScore = CenterControlScore.score(position: position, player: .attacker)
        let defScore = CenterControlScore.score(position: position, player: .defender)
        #expect(defScore > attScore)
    }

    @Test("single piece at center scores high")
    func singlePieceCenter() {
        let center = Position.boardSize / 2
        let position = emptyBoard()
            .placing(.attacker, row: center, col: center)
            .build()
        let score = CenterControlScore.score(position: position, player: .attacker)
        #expect(score == 3)
    }

    @Test("piece at edge of radius scores lower")
    func edgeOfRadius() {
        let center = Position.boardSize / 2
        let position = emptyBoard()
            .placing(.attacker, row: center - 2, col: center)
            .build()
        let edgeScore = CenterControlScore.score(position: position, player: .attacker)
        let centerPosition = emptyBoard()
            .placing(.attacker, row: center, col: center)
            .build()
        let centerScore = CenterControlScore.score(position: centerPosition, player: .attacker)
        #expect(centerScore > edgeScore)
    }
}
