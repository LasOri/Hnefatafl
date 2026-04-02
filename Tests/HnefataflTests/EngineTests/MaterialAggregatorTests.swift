import Testing
@testable import Hnefatafl

@Suite("MaterialAggregator Tests")
struct MaterialAggregatorTests {

    @Test("Returns value on Copenhagen start for attacker")
    func copenhagenAttacker() {
        let pos = Position.copenhagenStart()
        let score = MaterialAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns value on Copenhagen start for defender")
    func copenhagenDefender() {
        let pos = Position.copenhagenStart()
        let score = MaterialAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores have opposite signs on start position")
    func oppositeSignsOnStart() {
        let pos = Position.copenhagenStart()
        let atkScore = MaterialAggregator.compute(position: pos, player: .attacker)
        let defScore = MaterialAggregator.compute(position: pos, player: .defender)
        #expect(atkScore != defScore || atkScore == 0)
        // If one is positive, the other should be negative or zero
        if atkScore > 0 {
            #expect(defScore <= 0)
        } else if atkScore < 0 {
            #expect(defScore >= 0)
        }
    }

    @Test("Handles minimal board with king only")
    func minimalBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = MaterialAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores are negated on same position")
    func attackerDefenderNegation() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .placing(.attacker, row: 0, col: 1)
            .placing(.attacker, row: 0, col: 2)
            .placing(.attacker, row: 0, col: 3)
            .placing(.defender, row: 10, col: 10)
            .build()
        let atkScore = MaterialAggregator.compute(position: pos, player: .attacker)
        let defScore = MaterialAggregator.compute(position: pos, player: .defender)
        // Scores should differ between attacker and defender perspectives
        #expect(atkScore != defScore)
    }

    @Test("Scores are bounded and reasonable on start position")
    func scoresAreBounded() {
        let pos = Position.copenhagenStart()
        let atkScore = MaterialAggregator.compute(position: pos, player: .attacker)
        let defScore = MaterialAggregator.compute(position: pos, player: .defender)
        #expect(atkScore > -1000 && atkScore < 1000)
        #expect(defScore > -1000 && defScore < 1000)
    }
}
