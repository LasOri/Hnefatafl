import Testing
@testable import Hnefatafl

@Suite("ScoreDisplay Tests")
struct ScoreDisplayTests {

    @Test("start position scores")
    func startPositionScores() {
        let position = Position.copenhagenStart()
        let data = ScoreDisplay.compute(position: position)
        #expect(data.attackerScore == position.attackerCount * 100)
        #expect(data.defenderScore == position.defenderCount * 150)
    }

    @Test("advantage is Attacker at start")
    func attackerAdvantageAtStart() {
        let position = Position.copenhagenStart()
        let data = ScoreDisplay.compute(position: position)
        #expect(data.advantage == "Attacker")
    }

    @Test("empty board is Even")
    func emptyBoardEven() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let data = ScoreDisplay.compute(position: position)
        #expect(data.advantage == "Even")
    }

    @Test("attacker advantage with more attackers")
    func attackerAdvantage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        for i in 0..<20 { cells[i] = .attacker }
        let position = Position(cells: cells)
        let data = ScoreDisplay.compute(position: position)
        #expect(data.advantage == "Attacker")
    }

    @Test("ScoreDisplayData is Equatable")
    func equatable() {
        let a = ScoreDisplayData(attackerScore: 100, defenderScore: 200, advantage: "Defender")
        let b = ScoreDisplayData(attackerScore: 100, defenderScore: 200, advantage: "Defender")
        #expect(a == b)
    }
}
