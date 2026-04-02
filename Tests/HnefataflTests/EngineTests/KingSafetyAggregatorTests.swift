import Testing
@testable import Hnefatafl

@Suite("KingSafetyAggregator Tests")
struct KingSafetyAggregatorTests {

    @Test("Returns value on Copenhagen start for attacker")
    func copenhagenAttacker() {
        let pos = Position.copenhagenStart()
        let score = KingSafetyAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Returns value on Copenhagen start for defender")
    func copenhagenDefender() {
        let pos = Position.copenhagenStart()
        let score = KingSafetyAggregator.compute(position: pos, player: .defender)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("Attacker and defender scores are inverted")
    func attackerDefenderInverted() {
        let pos = Position.copenhagenStart()
        let atkScore = KingSafetyAggregator.compute(position: pos, player: .attacker)
        let defScore = KingSafetyAggregator.compute(position: pos, player: .defender)
        // KingSafetyAggregator explicitly returns -defenderSafety for attacker
        #expect(atkScore == -defScore)
    }

    @Test("Handles minimal board with king only")
    func minimalBoard() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        let score = KingSafetyAggregator.compute(position: pos, player: .attacker)
        #expect(score > Int.min)
        #expect(score < Int.max)
    }

    @Test("King near corner favors defender")
    func kingNearCornerFavorsDefender() {
        let pos = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let defScore = KingSafetyAggregator.compute(position: pos, player: .defender)
        let atkScore = KingSafetyAggregator.compute(position: pos, player: .attacker)
        #expect(defScore > atkScore)
    }

    @Test("King in center is less safe than king near corner for defender")
    func kingCenterVsCorner() {
        let centerPos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 0)
            .build()
        let cornerPos = emptyBoard()
            .placing(.king, row: 1, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let centerScore = KingSafetyAggregator.compute(position: centerPos, player: .defender)
        let cornerScore = KingSafetyAggregator.compute(position: cornerPos, player: .defender)
        // King near corner should score higher for defender (closer to escape)
        #expect(cornerScore > centerScore)
    }
}
