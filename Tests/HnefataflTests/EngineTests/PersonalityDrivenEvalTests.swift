import Testing
@testable import Hnefatafl

@Suite("Personality Driven Eval Tests")
struct PersonalityDrivenEvalTests {

    @Test("aggressive personality returns different score than defensive for same position")
    func aggressiveDiffersFromDefensive() {
        let position = Position.copenhagenStart()
        let aggScore = PersonalityDrivenEval.evaluate(position: position, player: .attacker, personality: .aggressive)
        let defScore = PersonalityDrivenEval.evaluate(position: position, player: .attacker, personality: .defensive)
        #expect(aggScore != defScore)
    }

    @Test("balanced personality evaluates start position to an integer")
    func balancedStartPositionInteger() {
        let position = Position.copenhagenStart()
        let score = PersonalityDrivenEval.evaluate(position: position, player: .defender, personality: .balanced)
        #expect(score is Int)
    }

    @Test("defender gets higher score when king has more escape routes")
    func defenderHigherWithMoreEscapes() {
        // King in open center: 4 escape routes, no threats
        let openPosition = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .placing(.attacker, row: 0, col: 0)
            .build()

        // King boxed in: fewer escape routes due to adjacent attackers
        let boxedPosition = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 4, col: 5)
            .placing(.defender, row: 3, col: 3)
            .build()

        let openScore = PersonalityDrivenEval.evaluate(position: openPosition, player: .defender, personality: .defensive)
        let boxedScore = PersonalityDrivenEval.evaluate(position: boxedPosition, player: .defender, personality: .defensive)
        #expect(openScore > boxedScore)
    }

    @Test("attacker gets higher score with more attacker pieces")
    func attackerHigherWithMorePieces() {
        let fewAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 0, col: 10)
            .build()

        let manyAttackers = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 0, col: 10)
            .placing(.attacker, row: 10, col: 0)
            .placing(.attacker, row: 10, col: 10)
            .placing(.attacker, row: 2, col: 2)
            .build()

        let fewScore = PersonalityDrivenEval.evaluate(position: fewAttackers, player: .attacker, personality: .aggressive)
        let manyScore = PersonalityDrivenEval.evaluate(position: manyAttackers, player: .attacker, personality: .aggressive)
        #expect(manyScore > fewScore)
    }

    @Test("all three personalities produce non-zero scores for start position")
    func allPersonalitiesNonZero() {
        let position = Position.copenhagenStart()
        for personality in AIPersonality.allCases {
            let score = PersonalityDrivenEval.evaluate(position: position, player: .attacker, personality: personality)
            #expect(score != 0, "Expected non-zero score for \(personality)")
        }
    }

    @Test("evaluation is deterministic for same inputs")
    func deterministicOutput() {
        let position = Position.copenhagenStart()
        let first = PersonalityDrivenEval.evaluate(position: position, player: .defender, personality: .balanced)
        let second = PersonalityDrivenEval.evaluate(position: position, player: .defender, personality: .balanced)
        #expect(first == second)
    }
}
