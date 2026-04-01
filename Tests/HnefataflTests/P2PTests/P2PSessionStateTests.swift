import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PSessionState Tests")
struct P2PSessionStateTests {

    @Test("default init has expected values")
    func defaultInit_values() {
        let session = P2PSessionState()
        #expect(session.isHost == false)
        #expect(session.localSide == nil)
        #expect(session.remotePeerId == nil)
        #expect(session.connectionState == .disconnected)
        #expect(session.localEndpointId == nil)
        #expect(session.variant == .copenhagen)
        #expect(session.messageSequence == 0)
        #expect(session.lastReceivedSequence == 0)
    }

    @Test("withConnectionState returns updated copy")
    func withConnectionState_updates() {
        let session = P2PSessionState(isHost: true)
        let updated = session.withConnectionState(.connected)
        #expect(updated.connectionState == .connected)
        #expect(updated.isHost == true)
    }

    @Test("withRemotePeer returns updated copy")
    func withRemotePeer_updates() {
        let session = P2PSessionState()
        let updated = session.withRemotePeer("peer-abc")
        #expect(updated.remotePeerId == "peer-abc")
    }

    @Test("withLocalSide returns updated copy")
    func withLocalSide_updates() {
        let session = P2PSessionState()
        let updated = session.withLocalSide(.defender)
        #expect(updated.localSide == .defender)
    }

    @Test("nextSequence increments by one")
    func nextSequence_increments() {
        let session = P2PSessionState(messageSequence: 5)
        let updated = session.nextSequence()
        #expect(updated.messageSequence == 6)
        #expect(updated.lastReceivedSequence == 0)
    }

    @Test("withReceivedSequence updates received only")
    func withReceivedSequence_updates() {
        let session = P2PSessionState(messageSequence: 3)
        let updated = session.withReceivedSequence(10)
        #expect(updated.lastReceivedSequence == 10)
        #expect(updated.messageSequence == 3)
    }
}
