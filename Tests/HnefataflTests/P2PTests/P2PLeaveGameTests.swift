import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P leaveGame Reducer Tests")
struct P2PLeaveGameTests {

    private func stateWith(session: P2PSessionState, variant: SelectedVariant = .copenhagen, captures: (Int, Int) = (0, 0)) -> GameState {
        GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: captures.0,
            defendersCaptured: captures.1,
            selectedVariant: variant,
            p2pSession: session
        )
    }

    @Test("leaveGame clears p2p session")
    func leaveGame_clearsSession() {
        let session = P2PSessionState(isHost: true, localSide: .defender, connectionState: .connected)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.p2pSession == nil)
    }

    @Test("leaveGame preserves game state")
    func leaveGame_preservesGame() {
        let session = P2PSessionState(isHost: true)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.game.currentPlayer == state.game.currentPlayer)
    }

    @Test("leaveGame preserves settings")
    func leaveGame_preservesSettings() {
        let session = P2PSessionState(isHost: true)
        let state = stateWith(session: session)
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.muted == state.muted)
        #expect(result.aiDifficulty == state.aiDifficulty)
    }

    @Test("leaveGame from non-P2P state is safe")
    func leaveGame_nonP2P_safe() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.p2pSession == nil)
    }

    @Test("leaveGame preserves captures")
    func leaveGame_preservesCaptures() {
        let session = P2PSessionState(isHost: true)
        let state = stateWith(session: session, captures: (3, 1))
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.attackersCaptured == 3)
        #expect(result.defendersCaptured == 1)
    }

    @Test("leaveGame preserves variant")
    func leaveGame_preservesVariant() {
        let session = P2PSessionState(isHost: true, variant: .tablut)
        let state = stateWith(session: session, variant: .tablut)
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.selectedVariant == .tablut)
    }
}
