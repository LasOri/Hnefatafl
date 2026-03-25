import Testing
@testable import Hnefatafl

@Suite("Game Outcome Summary Tests")
struct GameOutcomeSummaryTests {

    @Test("in-progress has no summary")
    func inProgress() {
        let summary = GameOutcomeSummary.summarize(status: .inProgress, moveCount: 10)
        #expect(summary == nil)
    }

    @Test("attacker wins summary")
    func attackerWins() {
        let summary = GameOutcomeSummary.summarize(status: .attackerWins, moveCount: 30)!
        #expect(summary.winner == .attacker)
        #expect(summary.moveCount == 30)
    }

    @Test("defender wins summary")
    func defenderWins() {
        let summary = GameOutcomeSummary.summarize(status: .defenderWins, moveCount: 25)!
        #expect(summary.winner == .defender)
    }

    @Test("draw summary has no winner")
    func draw() {
        let summary = GameOutcomeSummary.summarize(status: .draw, moveCount: 50)!
        #expect(summary.winner == nil)
    }

    @Test("summary includes description")
    func description() {
        let summary = GameOutcomeSummary.summarize(status: .attackerWins, moveCount: 15)!
        #expect(!summary.description.isEmpty)
    }

    @Test("description mentions winner")
    func descriptionMentionsWinner() {
        let summary = GameOutcomeSummary.summarize(status: .defenderWins, moveCount: 20)!
        #expect(summary.description.lowercased().contains("defender"))
    }

    @Test("draw description")
    func drawDescription() {
        let summary = GameOutcomeSummary.summarize(status: .draw, moveCount: 40)!
        #expect(summary.description.lowercased().contains("draw"))
    }

    @Test("OutcomeSummary is Equatable")
    func equatable() {
        let a = OutcomeSummary(winner: .attacker, moveCount: 10, description: "test")
        let b = OutcomeSummary(winner: .attacker, moveCount: 10, description: "test")
        #expect(a == b)
    }
}
