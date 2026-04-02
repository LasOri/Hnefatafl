import Testing
@testable import Hnefatafl

@Suite("TerritoryAggregator Tests")
struct TerritoryAggregatorTests {

    @Test("Returns value on Copenhagen start for attacker")
    func copenhagenAttacker() {
        let pos = Position.copenhagenStart()
        let score = TerritoryAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns value on Copenhagen start for defender")
    func copenhagenDefender() {
        let pos = Position.copenhagenStart()
        let score = TerritoryAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores have opposite signs on start position")
    func oppositeSignsOnStart() {
        let pos = Position.copenhagenStart()
        let atkScore = TerritoryAggregator.compute(position: pos, player: .attacker)
        let defScore = TerritoryAggregator.compute(position: pos, player: .defender)
        #expect(atkScore != defScore || atkScore == 0)
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
        let score = TerritoryAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Defender score on minimal board does not crash")
    func minimalBoardDefender() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = TerritoryAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Scores are bounded on start position")
    func scoresAreBounded() {
        let pos = Position.copenhagenStart()
        let atkScore = TerritoryAggregator.compute(position: pos, player: .attacker)
        let defScore = TerritoryAggregator.compute(position: pos, player: .defender)
        #expect(atkScore > -10000 && atkScore < 10000)
        #expect(defScore > -10000 && defScore < 10000)
    }
}
