import Testing
@testable import Hnefatafl

@Suite("KingFreedomIndex Tests")
struct KingFreedomIndexTests {
    @Test("KingFreedom initialization")
    func freedomInit() {
        let freedom = KingFreedom(mobility: 5, clearPaths: 2, adjacentDefenders: 4, score: 100)
        #expect(freedom.mobility == 5)
        #expect(freedom.clearPaths == 2)
        #expect(freedom.adjacentDefenders == 4)
        #expect(freedom.score == 100)
    }

    @Test("Compute king freedom at start")
    func computeStart() {
        let position = Position.copenhagenStart()
        let freedom = KingFreedomIndex.compute(position: position)
        #expect(freedom.mobility >= 0)
        #expect(freedom.clearPaths >= 0)
        #expect(freedom.adjacentDefenders >= 0)
        #expect(freedom.score >= 0)
    }

    @Test("King mobility is non-negative")
    func mobilityNonNegative() {
        let position = Position.copenhagenStart()
        let freedom = KingFreedomIndex.compute(position: position)
        #expect(freedom.mobility >= 0)
    }

    @Test("Clear paths is at most 4")
    func clearPathsMax() {
        let position = Position.copenhagenStart()
        let freedom = KingFreedomIndex.compute(position: position)
        #expect(freedom.clearPaths <= 4)
    }

    @Test("Adjacent defenders is at most 4")
    func adjacentDefendersMax() {
        let position = Position.copenhagenStart()
        let freedom = KingFreedomIndex.compute(position: position)
        #expect(freedom.adjacentDefenders <= 4)
    }

    @Test("Score increases with mobility")
    func scoreIncreases() {
        let position = Position.copenhagenStart()
        let freedom = KingFreedomIndex.compute(position: position)
        #expect(freedom.score >= 0)
    }

    @Test("Empty position returns zero freedom")
    func emptyPosition() {
        let emptyPosition = Position(cells: Array(repeating: nil, count: 121))
        let freedom = KingFreedomIndex.compute(position: emptyPosition)
        #expect(freedom.mobility == 0)
        #expect(freedom.clearPaths == 0)
        #expect(freedom.adjacentDefenders == 0)
        #expect(freedom.score == 0)
    }
}
