import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P assignSide Reducer Tests")
struct P2PAssignSideTests {

    private func stateWith(session: PeerSessionState) -> GameState {
        GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    @Test("assignSide updates localSide")
    func assignSide_updatesLocalSide() {
        let session = PeerSessionState(isHost: true, localRole: Player.defender.roleString)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession?.localRole == Player.attacker.roleString)
    }

    @Test("assignSide preserves other session fields")
    func assignSide_preservesSession() {
        let session = PeerSessionState(isHost: true, localRole: Player.defender.roleString, remotePeerId: "peer-1", connectionState: .connected)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession?.isHost == true)
        #expect(result.p2pSession?.remotePeerId == "peer-1")
        #expect(result.p2pSession?.connectionState == .connected)
    }

    @Test("assignSide is no-op without session")
    func assignSide_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession == nil)
    }

    @Test("assignSide to defender")
    func assignSide_toDefender() {
        let session = PeerSessionState(isHost: false, localRole: Player.attacker.roleString)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .defender))
        #expect(result.p2pSession?.localRole == Player.defender.roleString)
    }

    @Test("assignSide preserves game state")
    func assignSide_preservesGameState() {
        let session = PeerSessionState(isHost: true)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.game.currentPlayer == state.game.currentPlayer)
    }

    @Test("assignSide preserves variant")
    func assignSide_preservesVariant() {
        let session = PeerSessionState(isHost: true, variant: SelectedVariant.tablut.rawValue)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            selectedVariant: .tablut,
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.selectedVariant == .tablut)
    }
}
