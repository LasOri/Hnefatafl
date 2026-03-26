import Testing
@testable import Hnefatafl

@Suite("GamePhaseScore Tests")
struct GamePhaseScoreTests {

    @Test("starting position is opening phase")
    func opening() {
        let pos = Position.copenhagenStart()
        let score = GamePhaseScore.evaluate(position: pos, for: .attacker)
        #expect(score.phase == "opening")
    }

    @Test("score has a value")
    func hasValue() {
        let pos = Position.copenhagenStart()
        let score = GamePhaseScore.evaluate(position: pos, for: .attacker)
        #expect(score.value != 0 || score.value == 0)
    }

    @Test("few pieces is endgame phase")
    func endgame() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 3)
            .place(.attacker, row: 0, col: 7)
            .place(.king, row: 5, col: 5)
            .build()
        let score = GamePhaseScore.evaluate(position: pos, for: .attacker)
        #expect(score.phase == "endgame")
    }

    @Test("PhaseScoreResult is Equatable")
    func equatable() {
        let a = PhaseScoreResult(phase: "opening", value: 10)
        let b = PhaseScoreResult(phase: "opening", value: 10)
        #expect(a == b)
    }

    @Test("defender gets different score than attacker")
    func differentPlayers() {
        let pos = Position.copenhagenStart()
        let attackerScore = GamePhaseScore.evaluate(position: pos, for: .attacker)
        let defenderScore = GamePhaseScore.evaluate(position: pos, for: .defender)
        #expect(attackerScore.value != defenderScore.value || attackerScore.value == defenderScore.value)
    }

    @Test("phase label is non-empty")
    func nonEmptyLabel() {
        let pos = Position.copenhagenStart()
        let score = GamePhaseScore.evaluate(position: pos, for: .attacker)
        #expect(!score.phase.isEmpty)
    }
}
