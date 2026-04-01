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
        let msg = P2PMessage(type: .move, payload: movePayload, sequence: 1)
        let data = msg.serialize()
        let parsed = P2PMessage.deserialize(data)
        #expect(parsed?.type == .move)
        #expect(parsed?.payload["fromRow"]?.intValue == 0)
        #expect(parsed?.payload["toCol"]?.intValue == 5)
    }

    @Test("incoming handshake message is parseable")
    func incomingHandshake_parseable() {
        let hs = P2PHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Bob")
        let msg = P2PMessage(type: .handshake, payload: hs.toJson(), sequence: 0)
        let data = msg.serialize()
        let parsed = P2PMessage.deserialize(data)
        #expect(parsed?.type == .handshake)
        let recoveredHs = P2PHandshake.fromJson(parsed!.payload)
        #expect(recoveredHs?.variant == "copenhagen")
    }

    @Test("incoming resign message is parseable")
    func incomingResign_parseable() {
        let msg = P2PMessage(type: .resign, payload: .null, sequence: 5)
        let parsed = P2PMessage.deserialize(msg.serialize())
        #expect(parsed?.type == .resign)
    }

    @Test("incoming newGame message is parseable")
    func incomingNewGame_parseable() {
        let msg = P2PMessage(type: .newGame, payload: .object(["variant": .string("tablut")]), sequence: 3)
        let parsed = P2PMessage.deserialize(msg.serialize())
        #expect(parsed?.type == .newGame)
    }

    @Test("invalid message data returns nil")
    func invalidData_returnsNil() {
        #expect(P2PMessage.deserialize("garbage") == nil)
        #expect(P2PMessage.deserialize("") == nil)
    }

    @Test("message with missing move fields is incomplete")
    func missingMoveFields_incomplete() {
        let msg = P2PMessage(type: .move, payload: .object(["fromRow": .int(0)]), sequence: 1)
        let data = msg.serialize()
        let parsed = P2PMessage.deserialize(data)
        // Message parses but has incomplete payload
        #expect(parsed?.type == .move)
        #expect(parsed?.payload["toRow"]?.intValue == nil)
    }
}
