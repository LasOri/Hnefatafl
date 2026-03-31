import Testing
import LINKER
@testable import Hnefatafl

@Suite("MatchHistorySerializer Tests")
struct MatchHistorySerializerTests {

    @Test("serialize empty history")
    func serializeEmpty() {
        let history = MatchHistory()
        let json = MatchHistorySerializer.serialize(history)
        #expect(!json.isEmpty)
    }

    @Test("deserialize empty history")
    func deserializeEmpty() {
        let history = MatchHistory()
        let json = MatchHistorySerializer.serialize(history)
        let decoded = MatchHistorySerializer.deserialize(json)
        #expect(decoded != nil)
        #expect(decoded?.totalGames == 0)
    }

    @Test("serialize record with attacker winner")
    func serializeAttackerWin() {
        let record = MatchRecord(winner: .attacker, moveCount: 42, timestamp: 1000)
        let serialized = MatchHistorySerializer.serializeRecord(record)
        #expect(serialized["winner"]?.stringValue == "attacker")
        #expect(serialized["moveCount"]?.intValue == 42)
        #expect(serialized["timestamp"]?.doubleValue == 1000)
    }

    @Test("serialize record with defender winner")
    func serializeDefenderWin() {
        let record = MatchRecord(winner: .defender, moveCount: 30, timestamp: 2000)
        let serialized = MatchHistorySerializer.serializeRecord(record)
        #expect(serialized["winner"]?.stringValue == "defender")
    }

    @Test("serialize record with draw")
    func serializeDraw() {
        let record = MatchRecord(winner: nil, moveCount: 200, timestamp: 3000)
        let serialized = MatchHistorySerializer.serializeRecord(record)
        #expect(serialized["winner"]?.stringValue == "draw")
    }

    @Test("deserialize record from serialized")
    func deserializeRecord() {
        let serialized = Json.object(["winner": .string("attacker"), "moveCount": .int(42), "timestamp": .double(1000)])
        let record = MatchHistorySerializer.deserializeRecord(serialized)
        #expect(record != nil)
        #expect(record?.winner == .attacker)
        #expect(record?.moveCount == 42)
        #expect(record?.timestamp == 1000)
    }

    @Test("deserialize draw record")
    func deserializeDrawRecord() {
        let serialized = Json.object(["winner": .string("draw"), "moveCount": .int(200), "timestamp": .double(3000)])
        let record = MatchHistorySerializer.deserializeRecord(serialized)
        #expect(record?.winner == nil)
    }

    @Test("round trip history with records")
    func roundTrip() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 42, at: 1000)
        history.record(winner: .defender, moveCount: 30, at: 2000)
        history.record(winner: nil, moveCount: 200, at: 3000)

        let json = MatchHistorySerializer.serialize(history)
        let decoded = MatchHistorySerializer.deserialize(json)

        #expect(decoded != nil)
        #expect(decoded?.totalGames == 3)
        #expect(decoded?.attackerWins == 1)
        #expect(decoded?.defenderWins == 1)
        #expect(decoded?.draws == 1)
    }

    @Test("deserialize malformed JSON returns nil")
    func malformedJSON() {
        #expect(MatchHistorySerializer.deserialize("") == nil)
        #expect(MatchHistorySerializer.deserialize("{invalid}") == nil)
    }

    @Test("round trip preserves move counts")
    func roundTripMoveCounts() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 10, at: 100)
        history.record(winner: .defender, moveCount: 50, at: 200)

        let json = MatchHistorySerializer.serialize(history)
        let decoded = MatchHistorySerializer.deserialize(json)!

        #expect(decoded.records[0].moveCount == 10)
        #expect(decoded.records[1].moveCount == 50)
    }

    @Test("round trip preserves timestamps")
    func roundTripTimestamps() {
        var history = MatchHistory()
        history.record(winner: .attacker, moveCount: 10, at: 12345.6)

        let json = MatchHistorySerializer.serialize(history)
        let decoded = MatchHistorySerializer.deserialize(json)!

        #expect(decoded.records[0].timestamp == 12345.6)
    }

    @Test("deserialize invalid winner returns nil")
    func invalidWinner() {
        let serialized = Json.object(["winner": .string("unknown"), "moveCount": .int(10), "timestamp": .double(0)])
        let record = MatchHistorySerializer.deserializeRecord(serialized)
        #expect(record == nil)
    }
}
