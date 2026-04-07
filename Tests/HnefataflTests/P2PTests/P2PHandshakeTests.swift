import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PHandshake Tests")
struct P2PHandshakeTests {

    @Test("current protocol version is 1")
    func protocolVersion_isOne() {
        #expect(PeerHandshake.currentVersion == 1)
    }

    @Test("toJson includes all fields")
    func toJson_includesAllFields() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Alice")
        let json = hs.toJson()
        #expect(json["protocolVersion"]?.intValue == 1)
        #expect(json["variant"]?.stringValue == "copenhagen")
        #expect(json["playerName"]?.stringValue == "Alice")
    }

    @Test("toJson omits nil playerName")
    func toJson_omitsNilName() {
        let hs = PeerHandshake(protocolVersion: 1, variant: "tablut", playerName: nil)
        let json = hs.toJson()
        #expect(json["playerName"] == nil)
    }

    @Test("fromJson round-trips with toJson")
    func fromJson_roundTrips() {
        let original = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: "Bob")
        let json = original.toJson()
        let recovered = PeerHandshake.fromJson(json)
        #expect(recovered == original)
    }

    @Test("fromJson returns nil for missing fields")
    func fromJson_invalidReturnsNil() {
        #expect(PeerHandshake.fromJson(.null) == nil)
        #expect(PeerHandshake.fromJson(.object(["protocolVersion": .int(1)])) == nil)
    }

    @Test("handshake equality")
    func handshake_equality() {
        let a = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: nil)
        let b = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: nil)
        let c = PeerHandshake(protocolVersion: 2, variant: "copenhagen", playerName: nil)
        #expect(a == b)
        #expect(a != c)
    }
}
