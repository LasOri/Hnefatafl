import Testing
@testable import Hnefatafl

@Suite("Match Result Banner Tests")
struct MatchResultBannerTests {

    @Test("attacker wins title")
    func attackerWinsTitle() {
        let banner = MatchResultBanner(result: .attackerWins, moveCount: 30)
        #expect(banner.title == "Attackers Win!")
    }

    @Test("defender wins title")
    func defenderWinsTitle() {
        let banner = MatchResultBanner(result: .defenderWins, moveCount: 25)
        #expect(banner.title == "Defenders Win!")
    }

    @Test("draw title")
    func drawTitle() {
        let banner = MatchResultBanner(result: .draw, moveCount: 200)
        #expect(banner.title == "Draw")
    }

    @Test("in progress title")
    func inProgressTitle() {
        let banner = MatchResultBanner(result: .inProgress, moveCount: 10)
        #expect(banner.title == "Game In Progress")
    }

    @Test("subtitle includes move count")
    func subtitleMoveCount() {
        let banner = MatchResultBanner(result: .attackerWins, moveCount: 42)
        #expect(banner.subtitle == "Game ended in 42 moves")
    }

    @Test("equatable compares result and move count")
    func equatable() {
        let a = MatchResultBanner(result: .draw, moveCount: 50)
        let b = MatchResultBanner(result: .draw, moveCount: 50)
        #expect(a == b)
    }

    @Test("different results are not equal")
    func notEqual() {
        let a = MatchResultBanner(result: .attackerWins, moveCount: 30)
        let b = MatchResultBanner(result: .defenderWins, moveCount: 30)
        #expect(a != b)
    }
}
