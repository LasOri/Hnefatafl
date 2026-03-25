import Testing
@testable import Hnefatafl

@Suite("Game History Log Tests")
struct GameHistoryLogTests {

    @Test("empty log has no entries")
    func emptyLog() {
        let log = GameHistoryLog()
        #expect(log.entries.isEmpty)
    }

    @Test("record adds entry")
    func recordAdds() {
        let log = GameHistoryLog().record(entry: HistoryEntry(player: .attacker, notation: "D1-D5", moveNumber: 1))
        #expect(log.entries.count == 1)
    }

    @Test("entries are ordered")
    func ordered() {
        let log = GameHistoryLog()
            .record(entry: HistoryEntry(player: .attacker, notation: "D1-D5", moveNumber: 1))
            .record(entry: HistoryEntry(player: .defender, notation: "F6-F8", moveNumber: 1))
        #expect(log.entries[0].notation == "D1-D5")
        #expect(log.entries[1].notation == "F6-F8")
    }

    @Test("HistoryEntry stores player")
    func storesPlayer() {
        let entry = HistoryEntry(player: .defender, notation: "A1-A5", moveNumber: 3)
        #expect(entry.player == .defender)
        #expect(entry.moveNumber == 3)
    }

    @Test("clear removes all entries")
    func clear() {
        let log = GameHistoryLog()
            .record(entry: HistoryEntry(player: .attacker, notation: "D1-D5", moveNumber: 1))
            .clear()
        #expect(log.entries.isEmpty)
    }

    @Test("log from game moves")
    func fromGameMoves() {
        var game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        game = game.makeMove(move)
        let log = GameHistoryLog.from(game: game)
        #expect(log.entries.count == 1)
    }

    @Test("HistoryEntry is Equatable")
    func equatable() {
        let a = HistoryEntry(player: .attacker, notation: "D1-D5", moveNumber: 1)
        let b = HistoryEntry(player: .attacker, notation: "D1-D5", moveNumber: 1)
        #expect(a == b)
    }

    @Test("GameHistoryLog is Equatable")
    func logEquatable() {
        let a = GameHistoryLog()
        let b = GameHistoryLog()
        #expect(a == b)
    }
}
