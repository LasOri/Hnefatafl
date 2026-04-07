import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PMessage Tests")
struct P2PMessageTests {

    @Test("message type rawValues are correct")
    func messageType_rawValues() {
        #expect(PeerMessageType.handshake.rawValue == "handshake")
        #expect(PeerMessageType.move.rawValue == "move")
        #expect(PeerMessageType.stateSync.rawValue == "stateSync")
        #expect(PeerMessageType.ping.rawValue == "ping")
        #expect(PeerMessageType.pong.rawValue == "pong")
        #expect(PeerMessageType.resign.rawValue == "resign")
    }

    @Test("serialize produces valid JSON string")
    func serialize_producesJSON() {
        let msg = PeerMessage(type: .move, payload: .string("e4-e6"), sequence: 1)
        let json = msg.serialize()
        #expect(json.contains("\"type\":\"move\""))
        #expect(json.contains("\"sequence\":1"))
    }

    @Test("deserialize round-trips with serialize")
    func deserialize_roundTrips() {
        let original = PeerMessage(type: .handshake, payload: .object(["version": .int(1)]), sequence: 0)
        let serialized = original.serialize()
        let recovered = PeerMessage.deserialize(serialized)
        #expect(recovered == original)
    }

    @Test("deserialize returns nil for invalid JSON")
    func deserialize_invalidJSON() {
        #expect(PeerMessage.deserialize("not json") == nil)
        #expect(PeerMessage.deserialize("{}") == nil)
        #expect(PeerMessage.deserialize("{\"type\":\"invalid\"}") == nil)
    }

    @Test("message equality with same values")
    func equality_sameValues() {
        let a = PeerMessage(type: .ping, payload: .null, sequence: 5)
        let b = PeerMessage(type: .ping, payload: .null, sequence: 5)
        #expect(a == b)
    }

    @Test("message inequality with different sequences")
    func inequality_differentSequence() {
        let a = PeerMessage(type: .ping, payload: .null, sequence: 1)
        let b = PeerMessage(type: .ping, payload: .null, sequence: 2)
        #expect(a != b)
    }
}
