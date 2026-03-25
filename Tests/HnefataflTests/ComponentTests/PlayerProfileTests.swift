import Testing
@testable import Hnefatafl

@Suite("Player Profile Tests")
struct PlayerProfileTests {

    @Test("create profile with name")
    func createWithName() {
        let profile = PlayerProfile(name: "Viking")
        #expect(profile.name == "Viking")
    }

    @Test("default rating is 1200")
    func defaultRating() {
        let profile = PlayerProfile(name: "Test")
        #expect(profile.rating == 1200)
    }

    @Test("wins starts at zero")
    func winsZero() {
        let profile = PlayerProfile(name: "Test")
        #expect(profile.wins == 0)
    }

    @Test("record win increments")
    func recordWin() {
        var profile = PlayerProfile(name: "Test")
        profile.recordWin()
        #expect(profile.wins == 1)
    }

    @Test("record loss increments")
    func recordLoss() {
        var profile = PlayerProfile(name: "Test")
        profile.recordLoss()
        #expect(profile.losses == 1)
    }

    @Test("win rate computed")
    func winRate() {
        var profile = PlayerProfile(name: "Test")
        profile.recordWin()
        profile.recordWin()
        profile.recordLoss()
        #expect(abs(profile.winRate - 0.666) < 0.01)
    }

    @Test("total games computed")
    func totalGames() {
        var profile = PlayerProfile(name: "Test")
        profile.recordWin()
        profile.recordLoss()
        profile.recordDraw()
        #expect(profile.totalGames == 3)
    }

    @Test("PlayerProfile is Equatable")
    func equatable() {
        let a = PlayerProfile(name: "Test")
        let b = PlayerProfile(name: "Test")
        #expect(a == b)
    }
}
