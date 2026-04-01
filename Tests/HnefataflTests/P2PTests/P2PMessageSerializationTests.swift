import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PMessage Serialization Integration Tests")
struct P2PMessageSerializationTests {

    @Test("handshake message round-trips through serialize/deserialize")
    func handshake_roundTrip() {
        let handshake = P2PHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Alice")
        let msg = P2PMessage(type: .handshake, payload: handshake.toJson(), sequence: 0)
        let serialized = msg.serialize()
        let recovered = P2PMessage.deserialize(serialized)
        #expect(recovered != nil)
        let recoveredHandshake = P2PHandshake.fromJson(recovered!.payload)
        #expect(recoveredHandshake == handshake)
    }

    @Test("move message with coordinate payload")
    func moveMessage_coordinates() {
        let movePayload: Json = .object([
            "fromRow": .int(0), "fromCol": .int(3),
            "toRow": .int(0), "toCol": .int(5)
        ])
        let msg = P2PMessage(type: .move, payload: movePayload, sequence: 7)
        let serialized = msg.serialize()
        let recovered = P2PMessage.deserialize(serialized)
        #expect(recovered?.type == .move)
        #expect(recovered?.sequence == 7)
        #expect(recovered?.payload["fromRow"]?.intValue == 0)
        #expect(recovered?.payload["toCol"]?.intValue == 5)
    }

    @Test("stateSync message with full payload")
    func stateSync_fullPayload() {
        let sync = GameStateSyncPayload(
            cells: ["attacker", nil, "king"],
            currentPlayer: "defender",
            moveHistory: [[0, 3, 0, 5]],
            variant: "copenhagen"
        )
        let msg = P2PMessage(type: .stateSync, payload: sync.toJson(), sequence: 1)
        let serialized = msg.serialize()
        let recovered = P2PMessage.deserialize(serialized)
        let recoveredSync = GameStateSyncPayload.fromJson(recovered!.payload)
        #expect(recoveredSync == sync)
    }

    @Test("ping/pong messages with null payload")
    func pingPong_nullPayload() {
        let ping = P2PMessage(type: .ping, payload: .null, sequence: 10)
        let pong = P2PMessage(type: .pong, payload: .null, sequence: 11)
        #expect(P2PMessage.deserialize(ping.serialize())?.type == .ping)
        #expect(P2PMessage.deserialize(pong.serialize())?.type == .pong)
    }

    @Test("resign message round-trips")
    func resign_roundTrips() {
        let msg = P2PMessage(type: .resign, payload: .null, sequence: 42)
        let recovered = P2PMessage.deserialize(msg.serialize())
        #expect(recovered?.type == .resign)
        #expect(recovered?.sequence == 42)
    }

    @Test("newGame message round-trips")
    func newGame_roundTrips() {
        let payload: Json = .object(["variant": .string("tablut")])
        let msg = P2PMessage(type: .newGame, payload: payload, sequence: 0)
        let recovered = P2PMessage.deserialize(msg.serialize())
        #expect(recovered?.type == .newGame)
        #expect(recovered?.payload["variant"]?.stringValue == "tablut")
    }
}
