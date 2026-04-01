import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Heartbeat Tests")
struct P2PHeartbeatTests {

    @Test("ping message type is correct")
    func pingType_correct() {
        #expect(P2PMessageType.ping.rawValue == "ping")
    }

    @Test("pong message type is correct")
    func pongType_correct() {
        #expect(P2PMessageType.pong.rawValue == "pong")
    }

    @Test("ping message serializes with null payload")
    func ping_serializesCorrectly() {
        let msg = P2PMessage(type: .ping, payload: .null, sequence: 42)
        let data = msg.serialize()
        let recovered = P2PMessage.deserialize(data)
        #expect(recovered?.type == .ping)
        #expect(recovered?.sequence == 42)
    }

    @Test("pong echoes ping sequence number")
    func pong_echoesSequence() {
        let ping = P2PMessage(type: .ping, payload: .null, sequence: 7)
        let pong = P2PMessage(type: .pong, payload: .null, sequence: ping.sequence)
        #expect(pong.sequence == 7)
    }

    @Test("ping and pong are different types")
    func pingPong_differentTypes() {
        #expect(P2PMessageType.ping != P2PMessageType.pong)
    }

    @Test("ping/pong round-trip through serialize")
    func pingPong_roundTrip() {
        let ping = P2PMessage(type: .ping, payload: .null, sequence: 100)
        let pong = P2PMessage(type: .pong, payload: .null, sequence: 100)
        #expect(P2PMessage.deserialize(ping.serialize())?.type == .ping)
        #expect(P2PMessage.deserialize(pong.serialize())?.type == .pong)
    }
}
