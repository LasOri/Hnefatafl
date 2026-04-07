import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P remoteMove Reducer Tests")
struct P2PRemoteMoveTests {

    private func hostState() -> GameState {
        let session = PeerSessionState(
            isHost: true,
            localRole: Player.defender.roleString,
            connectionState: .connected,
            variant: SelectedVariant.copenhagen.rawValue
        )
        let game = Game()
        return GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    @Test("remoteMove applies when it is remote player's turn")
    func remoteMove_appliesWhenRemoteTurn() {
        let state = hostState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else {
            Issue.record("No legal moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
    }

    @Test("remoteMove is rejected when it is local player's turn")
    func remoteMove_rejectedWhenLocalTurn() {
        let session = PeerSessionState(
            isHost: false,
            localRole: Player.attacker.roleString,
            connectionState: .connected
        )
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("remoteMove is rejected without p2p session")
    func remoteMove_rejectedWithoutSession() {
        let state = GameState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("remoteMove increments received sequence")
    func remoteMove_incrementsSequence() {
        let state = hostState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.p2pSession?.lastReceivedSequence == 1)
    }

    @Test("remoteMove tracks captures")
    func remoteMove_tracksCaptureHistory() {
        let state = hostState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.captureHistory.count == 1)
    }

    @Test("remoteMove clears selection")
    func remoteMove_clearsSelection() {
        let state = hostState()
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.selectedSquare == nil)
        #expect(result.legalMovesForSelected.isEmpty)
    }
}
