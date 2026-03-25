import Testing
@testable import Hnefatafl

@Suite("Game Log Tests")
struct GameLogTests {

    @Test("new log is empty")
    func newLogIsEmpty() {
        let log = GameLog()
        #expect(log.count == 0)
        #expect(log.lastEntry == nil)
    }

    @Test("add entry increases count")
    func addEntryIncreasesCount() {
        var log = GameLog()
        log.addEntry(moveNumber: 1, player: .attacker, description: "a1-a5")
        #expect(log.count == 1)
    }

    @Test("last entry returns most recent")
    func lastEntryMostRecent() {
        var log = GameLog()
        log.addEntry(moveNumber: 1, player: .attacker, description: "first")
        log.addEntry(moveNumber: 2, player: .defender, description: "second")
        #expect(log.lastEntry?.description == "second")
        #expect(log.lastEntry?.moveNumber == 2)
    }

    @Test("clear removes all entries")
    func clearRemovesAll() {
        var log = GameLog()
        log.addEntry(moveNumber: 1, player: .attacker, description: "move")
        log.clear()
        #expect(log.count == 0)
        #expect(log.lastEntry == nil)
    }

    @Test("entries preserve order")
    func entriesPreserveOrder() {
        var log = GameLog()
        log.addEntry(moveNumber: 1, player: .attacker, description: "first")
        log.addEntry(moveNumber: 2, player: .defender, description: "second")
        log.addEntry(moveNumber: 3, player: .attacker, description: "third")
        #expect(log.entries[0].description == "first")
        #expect(log.entries[1].description == "second")
        #expect(log.entries[2].description == "third")
    }

    @Test("entry stores player correctly")
    func entryStoresPlayer() {
        var log = GameLog()
        log.addEntry(moveNumber: 1, player: .defender, description: "king moves")
        #expect(log.entries[0].player == .defender)
    }
}
