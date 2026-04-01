import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Handshake Flow Tests")
struct P2PHandshakeFlowTests {

    @Test("handshake with matching version succeeds")
    func matchingVersion_succeeds() {
        let hs = P2PHandshake(protocolVersion: P2PHandshake.currentVersion, variant: "copenhagen", playerName: nil)
        #expect(hs.protocolVersion == 1)
    }

    @Test("handshake with mismatched version detectable")
    func mismatchedVersion_detectable() {
        let hs = P2PHandshake(protocolVersion: 99, variant: "copenhagen", playerName: nil)
        #expect(hs.protocolVersion != P2PHandshake.currentVersion)
    }

    @Test("handshake variant matches host variant")
    func variant_matchesHost() {
        let session = P2PSessionState(isHost: true, variant: .tablut)
        let hs = P2PHandshake(protocolVersion: 1, variant: session.variant.rawValue, playerName: nil)
        #expect(hs.variant == "tablut")
    }

    @Test("handshake includes player name when provided")
    func playerName_included() {
        let hs = P2PHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Alice")
        let json = hs.toJson()
        let recovered = P2PHandshake.fromJson(json)
        #expect(recovered?.playerName == "Alice")
    }

    @Test("handshakeReceived action carries handshake data")
    func handshakeReceived_carriesData() {
        let hs = P2PHandshake(protocolVersion: 1, variant: "copenhagen", playerName: nil)
        let action = P2PGameAction.handshakeReceived(hs)
        if case .handshakeReceived(let received) = action {
            #expect(received.protocolVersion == 1)
        } else {
            Issue.record("Expected handshakeReceived")
        }
    }

    @Test("handshake round-trip through P2PMessage")
    func handshake_messageRoundTrip() {
        let hs = P2PHandshake(protocolVersion: 1, variant: "tablut", playerName: "Test")
        let msg = P2PMessage(type: .handshake, payload: hs.toJson(), sequence: 0)
        let data = msg.serialize()
        let recovered = P2PMessage.deserialize(data)
        let recoveredHs = P2PHandshake.fromJson(recovered!.payload)
        #expect(recoveredHs == hs)
    }
}
