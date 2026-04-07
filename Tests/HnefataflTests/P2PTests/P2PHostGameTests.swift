import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P hostGame Reducer Tests")
struct P2PHostGameTests {

    @Test("hostGame sets isHost to true")
    func hostGame_setsIsHost() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.isHost == true)
    }

    @Test("hostGame sets localRole to defender")
    func hostGame_setsDefender() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.localRole == Player.defender.roleString)
    }

    @Test("hostGame sets connectionState to connecting")
    func hostGame_setsConnecting() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.connectionState == .connecting)
    }

    @Test("hostGame uses requested variant")
    func hostGame_usesVariant() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .tablut))
        #expect(result.p2pSession?.variant == SelectedVariant.tablut.rawValue)
        #expect(result.selectedVariant == .tablut)
    }

    @Test("hostGame resets game to start position")
    func hostGame_resetsGame() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.game.currentPlayer == .attacker)
        #expect(result.game.moveHistory.isEmpty)
    }

    @Test("hostGame preserves settings")
    func hostGame_preservesSettings() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.muted == state.muted)
        #expect(result.showCoordinates == state.showCoordinates)
    }
}
