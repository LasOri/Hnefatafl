import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2P Remote Move Validation Tests")
struct P2PRemoteMoveValidationTests {

    // Helper: host is defender, remote is attacker, attacker's turn
    private func hostState() -> GameState {
        let session = P2PSessionState(
            isHost: true,
            localSide: .defender,
            connectionState: .connected,
            variant: .copenhagen
        )
        let game = Game()
        return GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    // MARK: - Out-of-bounds validation

    @Test("Out-of-bounds fromRow is rejected")
    func outOfBounds_negativeFromRow() {
        let state = hostState()
        let move = Move(fromRow: -1, fromCol: 3, toRow: 2, toCol: 3)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Out-of-bounds toRow is rejected")
    func outOfBounds_toRowTooLarge() {
        let state = hostState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 11, toCol: 3)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Out-of-bounds fromCol is rejected")
    func outOfBounds_negativeFromCol() {
        let state = hostState()
        let move = Move(fromRow: 0, fromCol: -5, toRow: 0, toCol: 3)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Out-of-bounds toCol is rejected")
    func outOfBounds_toColTooLarge() {
        let state = hostState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 99)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Exactly at board boundary is accepted when legal")
    func exactBoardBoundary_accepted() {
        // Row 10, col 10 are the max valid coords (boardSize=11, 0-indexed)
        let state = hostState()
        let legalMoves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = legalMoves.first else {
            Issue.record("No legal moves found for attacker")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
    }

    // MARK: - Illegal move validation

    @Test("Illegal move is rejected even if in bounds")
    func illegalMoveRejected() {
        let state = hostState()
        // Move from an empty square — no piece there
        let move = Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 5)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Diagonal move is rejected")
    func diagonalMoveRejected() {
        let state = hostState()
        // Attacker at (0,3) — diagonal move not legal in Hnefatafl
        let move = Move(fromRow: 0, fromCol: 3, toRow: 1, toCol: 4)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Move to occupied square is rejected")
    func moveToOccupiedRejected() {
        let state = hostState()
        // Try to move attacker on top of another piece
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 4)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    // MARK: - Legal move still works

    @Test("Legal remote move is applied correctly")
    func legalMoveApplied() {
        let state = hostState()
        let legalMoves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = legalMoves.first else {
            Issue.record("No legal moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
        #expect(result.captureHistory.count == 1)
        #expect(result.p2pSession?.lastReceivedSequence == 1)
    }

    // MARK: - Wrong turn (existing behavior preserved)

    @Test("Wrong-turn move is rejected")
    func wrongTurnRejected() {
        // Joiner is attacker (local), so it's attacker's turn = local turn.
        // A remote move should be rejected since it's not the remote's turn.
        let session = P2PSessionState(
            isHost: false,
            localSide: .attacker,
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

    // MARK: - Extreme out-of-bounds values

    @Test("Int.max coordinates are rejected")
    func intMaxCoordinatesRejected() {
        let state = hostState()
        let move = Move(fromRow: Int.max, fromCol: 0, toRow: 0, toCol: 0)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("Int.min coordinates are rejected")
    func intMinCoordinatesRejected() {
        let state = hostState()
        let move = Move(fromRow: 0, fromCol: 0, toRow: Int.min, toCol: 0)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }
}
