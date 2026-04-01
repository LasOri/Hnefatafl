import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Connection State Reducer Tests")
struct P2PConnectionStateTests {

    private func stateWith(session: P2PSessionState) -> GameState {
        GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    @Test("peerConnected sets connected state")
    func peerConnected_setsConnected() {
        let session = P2PSessionState(isHost: true, connectionState: .connecting)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "remote-peer"))
        #expect(result.p2pSession?.connectionState == .connected)
    }

    @Test("peerConnected stores remote peerId")
    func peerConnected_storesPeerId() {
        let session = P2PSessionState(isHost: true, connectionState: .connecting)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "remote-peer"))
        #expect(result.p2pSession?.remotePeerId == "remote-peer")
    }

    @Test("peerDisconnected sets disconnected state")
    func peerDisconnected_setsDisconnected() {
        let session = P2PSessionState(isHost: true, remotePeerId: "p", connectionState: .connected)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession?.connectionState == .disconnected)
    }

    @Test("peerConnected is no-op without session")
    func peerConnected_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "p"))
        #expect(result.p2pSession == nil)
    }

    @Test("peerDisconnected is no-op without session")
    func peerDisconnected_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession == nil)
    }

    @Test("peerConnected preserves other session fields")
    func peerConnected_preservesFields() {
        let session = P2PSessionState(isHost: true, localSide: .defender, connectionState: .connecting, variant: .tablut)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "p"))
        #expect(result.p2pSession?.isHost == true)
        #expect(result.p2pSession?.localSide == .defender)
        #expect(result.p2pSession?.variant == .tablut)
    }
}
