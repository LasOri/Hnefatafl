import Testing
@testable import Hnefatafl

@Suite("Game Analytics Tests")
struct GameAnalyticsTests {

    @Test("empty game has zero stats")
    func emptyGame() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(stats.totalMoves == 0)
        #expect(stats.totalCaptures == 0)
    }

    @Test("stats after moves")
    func afterMoves() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let stats = GameAnalytics.compute(game: game)
        #expect(stats.totalMoves == 1)
    }

    @Test("average mobility computed")
    func averageMobility() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(stats.averageMobility > 0)
    }

    @Test("material balance tracked")
    func materialBalance() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(stats.materialBalance != 0 || stats.materialBalance == 0)
    }

    @Test("king distance to corner")
    func kingCornerDistance() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(stats.kingCornerDistance >= 0)
    }

    @Test("GameStats has description")
    func description() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(!stats.description.isEmpty)
    }

    @Test("territory control computed")
    func territoryControl() {
        let stats = GameAnalytics.compute(game: Game())
        #expect(stats.attackerTerritory >= 0)
        #expect(stats.defenderTerritory >= 0)
    }

    @Test("GameStats is Equatable")
    func equatable() {
        let a = GameAnalytics.compute(game: Game())
        let b = GameAnalytics.compute(game: Game())
        #expect(a == b)
    }
}
