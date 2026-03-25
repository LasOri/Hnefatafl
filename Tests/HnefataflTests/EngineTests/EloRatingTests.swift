import Testing
@testable import Hnefatafl

@Suite("Elo Rating Tests")
struct EloRatingTests {

    @Test("initial rating is 1200")
    func initialRating() {
        let rating = EloRating()
        #expect(rating.value == 1200)
    }

    @Test("win against equal increases rating")
    func winIncreases() {
        let rating = EloRating()
        let updated = rating.updated(opponentRating: 1200, result: .win)
        #expect(updated.value > rating.value)
    }

    @Test("loss against equal decreases rating")
    func lossDecreases() {
        let rating = EloRating()
        let updated = rating.updated(opponentRating: 1200, result: .loss)
        #expect(updated.value < rating.value)
    }

    @Test("draw against equal stays close")
    func drawStaysClose() {
        let rating = EloRating()
        let updated = rating.updated(opponentRating: 1200, result: .draw)
        #expect(abs(updated.value - rating.value) < 5)
    }

    @Test("win against stronger gains more")
    func upsetGainsMore() {
        let rating = EloRating()
        let vsEqual = rating.updated(opponentRating: 1200, result: .win)
        let vsStrong = rating.updated(opponentRating: 1600, result: .win)
        #expect(vsStrong.value > vsEqual.value)
    }

    @Test("rating has floor of 100")
    func ratingFloor() {
        var rating = EloRating(value: 200)
        for _ in 0..<50 {
            rating = rating.updated(opponentRating: 2000, result: .loss)
        }
        #expect(rating.value >= 100)
    }

    @Test("k-factor defaults to 32")
    func defaultKFactor() {
        #expect(EloRating.defaultK == 32)
    }

    @Test("expected score against equal is 0.5")
    func expectedScoreEqual() {
        let expected = EloRating.expectedScore(rating: 1200, opponentRating: 1200)
        #expect(abs(expected - 0.5) < 0.01)
    }

    @Test("EloRating is Equatable")
    func equatable() {
        let a = EloRating(value: 1500)
        let b = EloRating(value: 1500)
        #expect(a == b)
    }

    @Test("GameResult has correct scores")
    func gameResultScores() {
        #expect(GameResult.win.score == 1.0)
        #expect(GameResult.loss.score == 0.0)
        #expect(GameResult.draw.score == 0.5)
    }
}
