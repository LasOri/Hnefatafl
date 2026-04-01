import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P joinGame Reducer Tests")
struct P2PJoinGameTests {

    @Test("joinGame sets isHost to false")
    func joinGame_setsNotHost() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "peer-abc"))
        #expect(result.p2pSession?.isHost == false)
    }

    @Test("joinGame sets localSide to attacker")
    func joinGame_setsAttacker() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "peer-abc"))
        #expect(result.p2pSession?.localSide == .attacker)
    }

    @Test("joinGame stores remote peerId")
    func joinGame_storesPeerId() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "peer-xyz"))
        #expect(result.p2pSession?.remotePeerId == "peer-xyz")
    }

    @Test("joinGame sets connectionState to connecting")
    func joinGame_setsConnecting() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "p"))
        #expect(result.p2pSession?.connectionState == .connecting)
    }

    @Test("joinGame preserves existing game state")
    func joinGame_preservesGame() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "p"))
        #expect(result.game.currentPlayer == state.game.currentPlayer)
    }

    @Test("joinGame sequence starts at zero")
    func joinGame_sequenceZero() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "p"))
        #expect(result.p2pSession?.messageSequence == 0)
        #expect(result.p2pSession?.lastReceivedSequence == 0)
    }
}
