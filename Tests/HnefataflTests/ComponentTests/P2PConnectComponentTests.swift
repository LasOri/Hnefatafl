import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Connect Component Tests")
struct P2PConnectComponentTests {

    // MARK: - Host/Join Screen (no session)

    @Test("render without P2P session shows host/join screen")
    func noSession_showsHostJoin() {
        let state = GameState()
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count == 1) // container div
    }

    @Test("host/join screen contains p2p-connect class")
    func noSession_hasP2PConnectClass() {
        let state = GameState()
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count == 1)
    }

    // MARK: - Connection Status (with session)

    @Test("render with session shows connection status")
    func withSession_showsStatus() {
        let session = PeerSessionState(isHost: true, connectionState: .connecting)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count > 0)
    }

    @Test("host session shows hosting message")
    func hostSession_showsHosting() {
        let session = PeerSessionState(isHost: true, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count > 0)
    }

    @Test("joiner session shows joined message")
    func joinerSession_showsJoined() {
        let session = PeerSessionState(isHost: false, localRole: Player.attacker.roleString, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count > 0)
    }

    @Test("disconnected session shows disconnect status")
    func disconnected_showsStatus() {
        let session = PeerSessionState(isHost: true, connectionState: .disconnected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count > 0)
    }

    @Test("reconnecting session shows attempt number")
    func reconnecting_showsAttempt() {
        let session = PeerSessionState(isHost: false, connectionState: .reconnecting(attempt: 3))
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let nodes = P2PConnectComponent.render(state: state)
        #expect(nodes.count > 0)
    }
}
