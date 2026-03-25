import Testing
@testable import Hnefatafl

@Suite("AdvancementScore Tests")
struct AdvancementScoreTests {
    @Test("Attacker advancement at Copenhagen start")
    func attackerAdvancementStart() {
        let position = Position.copenhagenStart()
        let score = AdvancementScore.attackerAdvancement(position: position)
        #expect(score >= 0)
    }

    @Test("Defender advancement at Copenhagen start")
    func defenderAdvancementStart() {
        let position = Position.copenhagenStart()
        let score = AdvancementScore.defenderAdvancement(position: position)
        #expect(score >= 0)
    }

    @Test("Empty board returns zero for attackers")
    func emptyBoardAttacker() {
        let position = emptyBoard().build()
        #expect(AdvancementScore.attackerAdvancement(position: position) == 0)
    }

    @Test("Edge attacker has zero advancement")
    func edgeAttackerZero() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 5)
            .build()
        #expect(AdvancementScore.attackerAdvancement(position: position) == 0)
    }

    @Test("Center attacker has maximum advancement")
    func centerAttackerMax() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(AdvancementScore.attackerAdvancement(position: position) == 5)
    }

    @Test("King at center has zero defender advancement")
    func kingAtCenterZero() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(AdvancementScore.defenderAdvancement(position: position) == 0)
    }

    @Test("King at corner has high defender advancement")
    func kingAtCornerHigh() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let score = AdvancementScore.defenderAdvancement(position: position)
        #expect(score == 10)
    }
}
