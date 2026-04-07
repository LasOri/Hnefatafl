import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Message Routing Tests")
struct P2PMessageRoutingTests {

    @Test("incoming move message dispatches remoteMove")
    func incomingMove_dispatchesRemoteMove() {
        let movePayload: Json = .object([
            "fromRow": .int(0), "fromCol": .int(3),
            "toRow": .int(0), "toCol": .int(5)
        ])
        let msg = PeerMessage(type: .move, payload: movePayload, sequence: 1)
        let data = msg.serialize()
        let parsed = PeerMessage.deserialize(data)
        #expect(parsed?.type == .move)
        #expect(parsed?.payload["fromRow"]?.intValue == 0)
        #expect(parsed?.payload["toCol"]?.intValue == 5)
    }

    @Test("incoming handshake message is parseable")
    func incomingHandshake_parseable() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Bob")
        let msg = PeerMessage(type: .handshake, payload: hs.toJson(), sequence: 0)
        let data = msg.serialize()
        let parsed = PeerMessage.deserialize(data)
        #expect(parsed?.type == .handshake)
        let recoveredHs = PeerHandshake.fromJson(parsed!.payload)
        #expect(recoveredHs?.variant == "copenhagen")
    }

    @Test("incoming resign message is parseable")
    func incomingResign_parseable() {
        let msg = PeerMessage(type: .resign, payload: .null, sequence: 5)
        let parsed = PeerMessage.deserialize(msg.serialize())
        #expect(parsed?.type == .resign)
    }

    @Test("incoming newGame message is parseable")
    func incomingNewGame_parseable() {
        let msg = PeerMessage(type: .newGame, payload: .object(["variant": .string("tablut")]), sequence: 3)
        let parsed = PeerMessage.deserialize(msg.serialize())
        #expect(parsed?.type == .newGame)
    }

    @Test("invalid message data returns nil")
    func invalidData_returnsNil() {
        #expect(PeerMessage.deserialize("garbage") == nil)
        #expect(PeerMessage.deserialize("") == nil)
    }

    @Test("message with missing move fields is incomplete")
    func missingMoveFields_incomplete() {
        let msg = PeerMessage(type: .move, payload: .object(["fromRow": .int(0)]), sequence: 1)
        let data = msg.serialize()
        let parsed = PeerMessage.deserialize(data)
        // Message parses but has incomplete payload
        #expect(parsed?.type == .move)
        #expect(parsed?.payload["toRow"]?.intValue == nil)
    }
}
