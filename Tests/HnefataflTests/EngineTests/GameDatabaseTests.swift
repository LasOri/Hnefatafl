import Testing
@testable import Hnefatafl

@Suite("GameDatabase Tests")
struct GameDatabaseTests {

    @Test("empty database has no entries")
    func emptyDatabase() {
        let db = GameDatabase()
        #expect(db.entries.isEmpty)
        #expect(db.count == 0)
    }

    @Test("add entry increases count")
    func addEntry() {
        var db = GameDatabase()
        let entry = GameDatabaseEntry(
            pgn: HnefataflPGN(headers: ["Event": "Test"], moves: []),
            result: .inProgress,
            moveCount: 0,
            timestamp: 1000
        )
        db.add(entry)
        #expect(db.count == 1)
    }

    @Test("entries are ordered by timestamp descending")
    func ordering() {
        var db = GameDatabase()
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .inProgress, moveCount: 0, timestamp: 100))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .inProgress, moveCount: 0, timestamp: 300))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .inProgress, moveCount: 0, timestamp: 200))
        #expect(db.entries[0].timestamp == 300)
        #expect(db.entries[1].timestamp == 200)
        #expect(db.entries[2].timestamp == 100)
    }

    @Test("filter by result")
    func filterByResult() {
        var db = GameDatabase()
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .attackerWins, moveCount: 10, timestamp: 100))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .defenderWins, moveCount: 20, timestamp: 200))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .attackerWins, moveCount: 15, timestamp: 300))
        let attackerWins = db.filter(result: .attackerWins)
        #expect(attackerWins.count == 2)
    }

    @Test("stats returns win counts")
    func stats() {
        var db = GameDatabase()
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .attackerWins, moveCount: 10, timestamp: 100))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .defenderWins, moveCount: 20, timestamp: 200))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 50, timestamp: 300))
        let stats = db.stats
        #expect(stats.attackerWins == 1)
        #expect(stats.defenderWins == 1)
        #expect(stats.draws == 1)
        #expect(stats.totalGames == 3)
    }

    @Test("GameDatabaseEntry is Equatable")
    func entryEquatable() {
        let a = GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 0, timestamp: 0)
        let b = GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 0, timestamp: 0)
        #expect(a == b)
    }

    @Test("latest returns most recent entry")
    func latest() {
        var db = GameDatabase()
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 0, timestamp: 100))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .attackerWins, moveCount: 5, timestamp: 500))
        #expect(db.latest?.timestamp == 500)
    }

    @Test("averageMoveCount computes correctly")
    func avgMoveCount() {
        var db = GameDatabase()
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 10, timestamp: 100))
        db.add(GameDatabaseEntry(pgn: HnefataflPGN(headers: [:], moves: []), result: .draw, moveCount: 30, timestamp: 200))
        #expect(db.stats.averageMoveCount == 20.0)
    }
}
