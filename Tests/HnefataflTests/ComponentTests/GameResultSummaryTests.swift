import Testing
@testable import Hnefatafl

@Suite("Game Result Summary Tests")
struct GameResultSummaryTests {

    @Test("attacker win summary")
    func attackerWin() {
        let data = GameResultSummary.summarize(status: .attackerWins, moveCount: 42, seconds: 180)
        #expect(data.result == "Attacker Victory")
        #expect(data.winner == .attacker)
    }

    @Test("defender win summary")
    func defenderWin() {
        let data = GameResultSummary.summarize(status: .defenderWins, moveCount: 30, seconds: 120)
        #expect(data.result == "Defender Victory")
        #expect(data.winner == .defender)
    }

    @Test("draw summary")
    func drawSummary() {
        let data = GameResultSummary.summarize(status: .draw, moveCount: 100, seconds: 600)
        #expect(data.result == "Draw")
        #expect(data.winner == nil)
    }

    @Test("duration is formatted as minutes:seconds")
    func durationFormatted() {
        let data = GameResultSummary.summarize(status: .inProgress, moveCount: 10, seconds: 65)
        #expect(data.duration == "1:05")
    }

    @Test("move count is preserved")
    func moveCountPreserved() {
        let data = GameResultSummary.summarize(status: .attackerWins, moveCount: 55, seconds: 0)
        #expect(data.moveCount == 55)
    }
}
