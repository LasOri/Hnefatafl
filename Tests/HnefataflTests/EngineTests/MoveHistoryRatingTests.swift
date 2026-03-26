import Testing
@testable import Hnefatafl

@Suite("MoveHistoryRating Tests")
struct MoveHistoryRatingTests {

    @Test("empty history has neutral rating")
    func emptyHistory() {
        let game = Game()
        let rating = MoveHistoryRating.rate(game: game)
        #expect(rating.score == 0)
    }

    @Test("one move game has a rating")
    func oneMove() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let rating = MoveHistoryRating.rate(game: game)
        #expect(rating.moveCount == 1)
    }

    @Test("rating includes move count")
    func moveCount() {
        var game = Game()
        let m1 = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(m1)
        let m2 = game.position.allLegalMoves(for: .defender).first!
        game = game.makeMove(m2)
        let rating = MoveHistoryRating.rate(game: game)
        #expect(rating.moveCount == 2)
    }

    @Test("MoveHistoryRatingResult is Equatable")
    func equatable() {
        let a = MoveHistoryRatingResult(score: 5, moveCount: 10, label: "Good")
        let b = MoveHistoryRatingResult(score: 5, moveCount: 10, label: "Good")
        #expect(a == b)
    }

    @Test("rating has a label")
    func hasLabel() {
        let game = Game()
        let rating = MoveHistoryRating.rate(game: game)
        #expect(!rating.label.isEmpty)
    }

    @Test("score is bounded")
    func bounded() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let rating = MoveHistoryRating.rate(game: game)
        #expect(rating.score >= -100 && rating.score <= 100)
    }
}
