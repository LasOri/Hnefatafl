import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P State Sync Tests")
struct P2PStateSyncTests {

    @Test("syncState payload captures board position")
    func syncPayload_capturesPosition() {
        let state = GameState()
        let cells: [String?] = state.game.position.cells.map { piece in
            switch piece {
            case .attacker: return "attacker"
            case .defender: return "defender"
            case .king: return "king"
            case nil: return nil
            }
        }
        let payload = GameStateSyncPayload(
            cells: cells,
            currentPlayer: "attacker",
            moveHistory: [],
            variant: "copenhagen"
        )
        #expect(payload.currentPlayer == "attacker")
        #expect(payload.variant == "copenhagen")
        #expect(payload.cells.count == state.game.position.cells.count)
    }

    @Test("syncState payload round-trips through JSON")
    func syncPayload_roundTrips() {
        let payload = GameStateSyncPayload(
            cells: ["attacker", nil, "king", "defender"],
            currentPlayer: "defender",
            moveHistory: [[0, 3, 0, 5]],
            variant: "tablut"
        )
        let json = payload.toJson()
        let recovered = GameStateSyncPayload.fromJson(json)
        #expect(recovered == payload)
    }

    @Test("syncState inside PeerMessage round-trips")
    func syncInMessage_roundTrips() {
        let payload = GameStateSyncPayload(
            cells: ["attacker"],
            currentPlayer: "attacker",
            moveHistory: [],
            variant: "copenhagen"
        )
        let msg = PeerMessage(type: .stateSync, payload: payload.toJson(), sequence: 5)
        let data = msg.serialize()
        let recovered = PeerMessage.deserialize(data)
        #expect(recovered?.type == .stateSync)
        let recoveredPayload = GameStateSyncPayload.fromJson(recovered!.payload)
        #expect(recoveredPayload == payload)
    }

    @Test("syncState reducer is no-op for now")
    func syncReducer_noop() {
        let session = PeerSessionState(isHost: false, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let payload = GameStateSyncPayload(
            cells: [],
            currentPlayer: "attacker",
            moveHistory: [],
            variant: "copenhagen"
        )
        let result = p2pGameReducer(state: state, action: .syncState(payload))
        #expect(result.p2pSession?.connectionState == .connected)
    }

    @Test("P2P store created with middleware")
    func p2pStore_createdWithMiddleware() {
        let store = createP2PGameStore()
        let state = store.getState()
        #expect(state.p2pSession == nil)
        #expect(state.game.currentPlayer == .attacker)
    }

    @Test("regular store also handles P2PGameAction")
    func regularStore_handlesP2PAction() {
        let store = createGameStore()
        store.dispatch(P2PGameAction.hostGame(variant: .copenhagen))
        let state = store.getState()
        #expect(state.p2pSession?.isHost == true)
    }
}
