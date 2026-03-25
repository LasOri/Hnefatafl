import Testing
@testable import Hnefatafl

@Suite("GameSummary Tests")
struct GameSummaryTests {

    @Test("summary of starting position game")
    func startingGame() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(!summary.text.isEmpty)
    }

    @Test("summary includes move count")
    func moveCount() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(summary.moveCount == 0)
    }

    @Test("summary includes status")
    func status() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(summary.status == .inProgress)
    }

    @Test("summary after one move")
    func afterOneMove() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let game2 = game.makeMove(moves[0])
        let summary = GameSummary.generate(game: game2)
        #expect(summary.moveCount == 1)
        #expect(summary.text.contains("1"))
    }

    @Test("summary includes piece counts")
    func pieceCounts() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(summary.attackerCount == 24)
        #expect(summary.defenderCount == 13)
    }

    @Test("GameSummaryResult is Equatable")
    func equatable() {
        let a = GameSummaryResult(text: "Test", moveCount: 0, status: .inProgress, attackerCount: 24, defenderCount: 13)
        let b = GameSummaryResult(text: "Test", moveCount: 0, status: .inProgress, attackerCount: 24, defenderCount: 13)
        #expect(a == b)
    }

    @Test("summary text mentions current player")
    func mentionsPlayer() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(summary.text.lowercased().contains("attacker"))
    }

    @Test("summary text is multi-line")
    func multiLine() {
        let game = Game()
        let summary = GameSummary.generate(game: game)
        #expect(summary.text.contains("\n"))
    }
}
