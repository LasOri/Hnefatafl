import Testing
@testable import Hnefatafl

@Suite("GameArchive Tests")
struct GameArchiveTests {

    @Test("empty archive has no games")
    func empty() {
        let archive = GameArchive()
        #expect(archive.count == 0)
        #expect(archive.games.isEmpty)
    }

    @Test("add game to archive")
    func addGame() {
        var archive = GameArchive()
        let entry = ArchivedGame(moves: [], result: .inProgress, tags: [], note: "")
        archive.add(entry)
        #expect(archive.count == 1)
    }

    @Test("filter by tag")
    func filterByTag() {
        var archive = GameArchive()
        archive.add(ArchivedGame(moves: [], result: .attackerWins, tags: ["ranked"], note: ""))
        archive.add(ArchivedGame(moves: [], result: .defenderWins, tags: ["casual"], note: ""))
        archive.add(ArchivedGame(moves: [], result: .draw, tags: ["ranked"], note: ""))
        let ranked = archive.filter(tag: "ranked")
        #expect(ranked.count == 2)
    }

    @Test("filter by result")
    func filterByResult() {
        var archive = GameArchive()
        archive.add(ArchivedGame(moves: [], result: .attackerWins, tags: [], note: ""))
        archive.add(ArchivedGame(moves: [], result: .defenderWins, tags: [], note: ""))
        #expect(archive.filter(result: .attackerWins).count == 1)
    }

    @Test("ArchivedGame is Equatable")
    func equatable() {
        let a = ArchivedGame(moves: [], result: .draw, tags: ["a"], note: "test")
        let b = ArchivedGame(moves: [], result: .draw, tags: ["a"], note: "test")
        #expect(a == b)
    }

    @Test("archive note stored")
    func note() {
        var archive = GameArchive()
        archive.add(ArchivedGame(moves: [], result: .inProgress, tags: [], note: "Great game"))
        #expect(archive.games[0].note == "Great game")
    }

    @Test("tags stored correctly")
    func tags() {
        let entry = ArchivedGame(moves: [], result: .draw, tags: ["ranked", "tournament"], note: "")
        #expect(entry.tags.count == 2)
        #expect(entry.tags.contains("ranked"))
    }

    @Test("clear removes all games")
    func clear() {
        var archive = GameArchive()
        archive.add(ArchivedGame(moves: [], result: .draw, tags: [], note: ""))
        archive.clear()
        #expect(archive.count == 0)
    }
}
