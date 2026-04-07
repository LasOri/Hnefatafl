import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Handshake Flow Tests")
struct P2PHandshakeFlowTests {

    @Test("handshake with matching version succeeds")
    func matchingVersion_succeeds() {
        let hs = PeerHandshake(protocolVersion: PeerHandshake.currentVersion, variant: "copenhagen", playerName: nil)
        #expect(hs.protocolVersion == 1)
    }

    @Test("handshake with mismatched version detectable")
    func mismatchedVersion_detectable() {
        let hs = PeerHandshake(protocolVersion: 99, variant: "copenhagen", playerName: nil)
        #expect(hs.protocolVersion != PeerHandshake.currentVersion)
    }

    @Test("handshake variant matches host variant")
    func variant_matchesHost() {
        let session = PeerSessionState(isHost: true, variant: SelectedVariant.tablut.rawValue)
        let hs = PeerHandshake(protocolVersion: 1, variant: session.variant!, playerName: nil)
        #expect(hs.variant == "tablut")
    }

    @Test("handshake includes player name when provided")
    func playerName_included() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Alice")
        let json = hs.toJson()
        let recovered = PeerHandshake.fromJson(json)
        #expect(recovered?.playerName == "Alice")
    }

    @Test("handshakeReceived action carries handshake data")
    func handshakeReceived_carriesData() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: nil)
        let action = P2PGameAction.handshakeReceived(hs)
        if case .handshakeReceived(let received) = action {
            #expect(received.protocolVersion == 1)
        } else {
            Issue.record("Expected handshakeReceived")
        }
    }

    @Test("handshake round-trip through P2PMessage")
    func handshake_messageRoundTrip() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "tablut", playerName: "Test")
        let msg = PeerMessage(type: .handshake, payload: hs.toJson(), sequence: 0)
        let data = msg.serialize()
        let recovered = PeerMessage.deserialize(data)
        let recoveredHs = PeerHandshake.fromJson(recovered!.payload)
        #expect(recoveredHs == hs)
    }
}
