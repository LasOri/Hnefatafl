import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Reconnection Tests")
struct P2PReconnectionTests {

    @Test("peerDisconnected sets disconnected state")
    func disconnect_setsState() {
        let session = P2PSessionState(isHost: true, remotePeerId: "p", connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession?.connectionState == .disconnected)
    }

    @Test("reconnect sets connecting state")
    func reconnect_setsConnecting() {
        let session = P2PSessionState(isHost: false, localSide: .attacker, connectionState: .disconnected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        // Joining again would set connecting
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "peer-new"))
        #expect(result.p2pSession?.connectionState == .connecting)
    }

    @Test("session preserved after disconnect")
    func session_preservedAfterDisconnect() {
        let session = P2PSessionState(isHost: true, localSide: .defender, remotePeerId: "p", connectionState: .connected, variant: .tablut)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession?.isHost == true)
        #expect(result.p2pSession?.localSide == .defender)
        #expect(result.p2pSession?.variant == .tablut)
    }

    @Test("game state preserved during reconnect")
    func gameState_preservedDuringReconnect() {
        let session = P2PSessionState(isHost: true, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 2,
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.attackersCaptured == 2)
    }

    @Test("P2PConnectionState reconnecting has attempt number")
    func reconnecting_hasAttempt() {
        let state: P2PConnectionState = .reconnecting(attempt: 3)
        if case .reconnecting(let attempt) = state {
            #expect(attempt == 3)
        } else {
            Issue.record("Expected reconnecting")
        }
    }

    @Test("leaveGame after disconnect clears session")
    func leaveAfterDisconnect_clearsSession() {
        let session = P2PSessionState(isHost: true, connectionState: .disconnected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.p2pSession == nil)
    }
}
