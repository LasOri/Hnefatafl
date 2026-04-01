import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PMessage Tests")
struct P2PMessageTests {

    @Test("message type rawValues are correct")
    func messageType_rawValues() {
        #expect(P2PMessageType.handshake.rawValue == "handshake")
        #expect(P2PMessageType.move.rawValue == "move")
        #expect(P2PMessageType.stateSync.rawValue == "stateSync")
        #expect(P2PMessageType.ping.rawValue == "ping")
        #expect(P2PMessageType.pong.rawValue == "pong")
        #expect(P2PMessageType.resign.rawValue == "resign")
    }

    @Test("serialize produces valid JSON string")
    func serialize_producesJSON() {
        let msg = P2PMessage(type: .move, payload: .string("e4-e6"), sequence: 1)
        let json = msg.serialize()
        #expect(json.contains("\"type\":\"move\""))
        #expect(json.contains("\"sequence\":1"))
    }

    @Test("deserialize round-trips with serialize")
    func deserialize_roundTrips() {
        let original = P2PMessage(type: .handshake, payload: .object(["version": .int(1)]), sequence: 0)
        let serialized = original.serialize()
        let recovered = P2PMessage.deserialize(serialized)
        #expect(recovered == original)
    }

    @Test("deserialize returns nil for invalid JSON")
    func deserialize_invalidJSON() {
        #expect(P2PMessage.deserialize("not json") == nil)
        #expect(P2PMessage.deserialize("{}") == nil)
        #expect(P2PMessage.deserialize("{\"type\":\"invalid\"}") == nil)
    }

    @Test("message equality with same values")
    func equality_sameValues() {
        let a = P2PMessage(type: .ping, payload: .null, sequence: 5)
        let b = P2PMessage(type: .ping, payload: .null, sequence: 5)
        #expect(a == b)
    }

    @Test("message inequality with different sequences")
    func inequality_differentSequence() {
        let a = P2PMessage(type: .ping, payload: .null, sequence: 1)
        let b = P2PMessage(type: .ping, payload: .null, sequence: 2)
        #expect(a != b)
    }
}
