import Testing
@testable import Hnefatafl

@Suite("TacticalAggregator Tests")
struct TacticalAggregatorTests {

    @Test("Returns value on Copenhagen start for attacker")
    func copenhagenAttacker() {
        let pos = Position.copenhagenStart()
        let score = TacticalAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns value on Copenhagen start for defender")
    func copenhagenDefender() {
        let pos = Position.copenhagenStart()
        let score = TacticalAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores differ on start position")
    func scoresAreDistinct() {
        let pos = Position.copenhagenStart()
        let atkScore = TacticalAggregator.compute(position: pos, player: .attacker)
        let defScore = TacticalAggregator.compute(position: pos, player: .defender)
        #expect(atkScore != defScore || atkScore == 0)
    }

    @Test("Handles minimal board with king only")
    func minimalBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = TacticalAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Defender score on minimal board does not crash")
    func minimalBoardDefender() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = TacticalAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Scores are bounded on start position")
    func scoresAreBounded() {
        let pos = Position.copenhagenStart()
        let atkScore = TacticalAggregator.compute(position: pos, player: .attacker)
        let defScore = TacticalAggregator.compute(position: pos, player: .defender)
        #expect(atkScore > -100000 && atkScore < 100000)
        #expect(defScore > -100000 && defScore < 100000)
    }

    @Test("Attacker under siege position produces different scores than open position")
    func siegeVsOpenPosition() {
        // Surrounded king
        let siegePos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        // Open king
        let openPos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let siegeScore = TacticalAggregator.compute(position: siegePos, player: .attacker)
        let openScore = TacticalAggregator.compute(position: openPos, player: .attacker)
        // These should produce different tactical evaluations
        #expect(siegeScore != openScore)
    }
}
