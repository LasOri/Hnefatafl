import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Error Handling Tests")
struct P2PErrorHandlingTests {

    @Test("connectionError action carries message")
    func connectionError_carriesMessage() {
        let action = P2PGameAction.connectionError("network timeout")
        if case .connectionError(let msg) = action {
            #expect(msg == "network timeout")
        } else {
            Issue.record("Expected connectionError")
        }
    }

    @Test("connectionError does not modify state")
    func connectionError_noStateChange() {
        let session = P2PSessionState(isHost: true, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let result = p2pGameReducer(state: state, action: .connectionError("err"))
        #expect(result.p2pSession?.connectionState == .connected)
    }

    @Test("P2PConnectionState failed carries error")
    func failedState_carriesError() {
        let error = P2PError.connectionFailed("timeout")
        let state: P2PConnectionState = .failed(error)
        if case .failed(let e) = state {
            #expect(e == .connectionFailed("timeout"))
        } else {
            Issue.record("Expected .failed")
        }
    }

    @Test("remoteMove with nil localSide is rejected")
    func remoteMove_nilLocalSide_rejected() {
        let session = P2PSessionState(isHost: true, localSide: nil, connectionState: .connected)
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("P2PError notSupported description is correct")
    func notSupported_description() {
        let error = P2PError.notSupported
        #expect(error.description == "P2P not supported in this environment")
    }

    @Test("P2PError timeout equality")
    func timeout_equality() {
        #expect(P2PError.timeout == P2PError.timeout)
        #expect(P2PError.timeout != P2PError.notSupported)
    }
}
