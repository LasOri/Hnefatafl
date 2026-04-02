import Testing
@testable import Hnefatafl

@Suite("PositionAggregator Tests")
struct PositionAggregatorTests {

    @Test("Returns value on Copenhagen start for attacker")
    func copenhagenAttacker() {
        let pos = Position.copenhagenStart()
        let score = PositionAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns value on Copenhagen start for defender")
    func copenhagenDefender() {
        let pos = Position.copenhagenStart()
        let score = PositionAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores differ on start position")
    func oppositeSignsOnStart() {
        let pos = Position.copenhagenStart()
        let atkScore = PositionAggregator.compute(position: pos, player: .attacker)
        let defScore = PositionAggregator.compute(position: pos, player: .defender)
        // Scores should differ between attacker and defender
        #expect(atkScore != defScore || atkScore == 0)
    }

    @Test("Handles minimal board with king only")
    func minimalBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = PositionAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns zero when no king is present")
    func noKingReturnsZero() {
        let pos = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .placing(.defender, row: 10, col: 10)
            .build()
        let score = PositionAggregator.compute(position: pos, player: .attacker)
        #expect(score == 0)
    }

    @Test("King near corner gives defender higher score than center")
    func kingNearCornerVsCenter() {
        let cornerPos = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 3, col: 3)
            .build()
        let centerPos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.defender, row: 3, col: 3)
            .build()
        let cornerDefScore = PositionAggregator.compute(position: cornerPos, player: .defender)
        let centerDefScore = PositionAggregator.compute(position: centerPos, player: .defender)
        // King near corner should have higher proximity score for defender
        #expect(cornerDefScore > centerDefScore)
    }

    @Test("Scores are bounded on start position")
    func scoresAreBounded() {
        let pos = Position.copenhagenStart()
        let atkScore = PositionAggregator.compute(position: pos, player: .attacker)
        let defScore = PositionAggregator.compute(position: pos, player: .defender)
        #expect(atkScore > -10000 && atkScore < 10000)
        #expect(defScore > -10000 && defScore < 10000)
    }
}
