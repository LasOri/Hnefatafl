import Testing
import LINKER
@testable import Hnefatafl

@Suite("P2PGameReducer Tests")
struct P2PGameReducerTests {

    // MARK: - Helpers

    private func stateWithP2PSession(
        localSide: Player? = .defender,
        isHost: Bool = true,
        connectionState: P2PConnectionState = .connected,
        remotePeerId: String? = "peer-123",
        variant: SelectedVariant = .copenhagen
    ) -> GameState {
        let session = PeerSessionState(
            isHost: isHost,
            localRole: localSide?.roleString,
            remotePeerId: remotePeerId,
            connectionState: connectionState,
            variant: variant.rawValue
        )
        return GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
    }

    // MARK: - hostGame

    @Test("hostGame creates session with isHost true")
    func hostGame_isHostTrue() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.isHost == true)
    }

    @Test("hostGame sets localSide to defender")
    func hostGame_localSideDefender() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.localRole == Player.defender.roleString)
    }

    @Test("hostGame sets connectionState to connecting")
    func hostGame_connectionStateConnecting() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.connectionState == .connecting)
    }

    @Test("hostGame starts new game with attacker to move")
    func hostGame_startsNewGame() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.game.currentPlayer == .attacker)
        #expect(result.game.moveHistory.isEmpty)
    }

    @Test("hostGame uses the requested variant for session and selectedVariant")
    func hostGame_usesVariant() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .tablut))
        #expect(result.p2pSession?.variant == SelectedVariant.tablut.rawValue)
        #expect(result.selectedVariant == .tablut)
    }

    @Test("hostGame preserves muted and showCoordinates settings")
    func hostGame_preservesSettings() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            muted: true,
            showCoordinates: false
        )
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.muted == true)
        #expect(result.showCoordinates == false)
    }

    @Test("hostGame remotePeerId is nil initially")
    func hostGame_noPeerId() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .hostGame(variant: .copenhagen))
        #expect(result.p2pSession?.remotePeerId == nil)
    }

    // MARK: - joinGame

    @Test("joinGame creates session with isHost false")
    func joinGame_isHostFalse() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "remote-42"))
        #expect(result.p2pSession?.isHost == false)
    }

    @Test("joinGame sets localSide to attacker")
    func joinGame_localSideAttacker() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "remote-42"))
        #expect(result.p2pSession?.localRole == Player.attacker.roleString)
    }

    @Test("joinGame sets connectionState to connecting")
    func joinGame_connectionStateConnecting() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "remote-42"))
        #expect(result.p2pSession?.connectionState == .connecting)
    }

    @Test("joinGame stores remotePeerId")
    func joinGame_storesRemotePeerId() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "remote-42"))
        #expect(result.p2pSession?.remotePeerId == "remote-42")
    }

    @Test("joinGame preserves existing game state")
    func joinGame_preservesGame() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .joinGame(peerId: "remote-42"))
        #expect(result.game.currentPlayer == state.game.currentPlayer)
        #expect(result.game.position == state.game.position)
    }

    // MARK: - leaveGame

    @Test("leaveGame sets p2pSession to nil")
    func leaveGame_clearsSession() {
        let state = stateWithP2PSession()
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.p2pSession == nil)
    }

    @Test("leaveGame preserves game state")
    func leaveGame_preservesGame() {
        let state = stateWithP2PSession()
        let result = p2pGameReducer(state: state, action: .leaveGame)
        #expect(result.game.currentPlayer == state.game.currentPlayer)
    }

    // MARK: - assignSide

    @Test("assignSide updates localSide on existing session")
    func assignSide_updatesLocalSide() {
        let state = stateWithP2PSession(localSide: .defender)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession?.localRole == Player.attacker.roleString)
    }

    @Test("assignSide returns unchanged state when no session")
    func assignSide_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession == nil)
    }

    @Test("assignSide preserves other session fields")
    func assignSide_preservesSessionFields() {
        let state = stateWithP2PSession(localSide: .defender, isHost: true, connectionState: .connected, remotePeerId: "p1", variant: .tablut)
        let result = p2pGameReducer(state: state, action: .assignSide(localSide: .attacker))
        #expect(result.p2pSession?.isHost == true)
        #expect(result.p2pSession?.connectionState == .connected)
        #expect(result.p2pSession?.remotePeerId == "p1")
        #expect(result.p2pSession?.variant == SelectedVariant.tablut.rawValue)
    }

    // MARK: - remoteMove (legal move)

    @Test("remoteMove applies legal move when it is remote player's turn")
    func remoteMove_appliesLegalMove() {
        // Host is defender, current player is attacker (remote), so remote move is allowed
        let state = stateWithP2PSession(localSide: .defender)
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else {
            Issue.record("No legal attacker moves found")
            return
        }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == move)
        #expect(result.game.currentPlayer == .defender)
    }

    @Test("remoteMove rejects move when it is not remote player's turn")
    func remoteMove_rejectsWhenLocalTurn() {
        // Local is attacker, current player is also attacker → not remote's turn
        let state = stateWithP2PSession(localSide: .attacker)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("remoteMove returns unchanged when no p2p session")
    func remoteMove_noopWithoutSession() {
        let state = GameState()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("remoteMove returns unchanged when localSide is nil")
    func remoteMove_noopWhenLocalSideNil() {
        let state = stateWithP2PSession(localSide: nil)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.lastMove == nil)
    }

    @Test("remoteMove increments lastReceivedSequence")
    func remoteMove_incrementsSequence() {
        let state = stateWithP2PSession(localSide: .defender)
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.p2pSession?.lastReceivedSequence == 1)
    }

    @Test("remoteMove clears selection and legal moves")
    func remoteMove_clearsSelection() {
        let state = stateWithP2PSession(localSide: .defender)
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.selectedSquare == nil)
        #expect(result.legalMovesForSelected.isEmpty)
    }

    @Test("remoteMove appends to captureHistory")
    func remoteMove_appendsCaptureHistory() {
        let state = stateWithP2PSession(localSide: .defender)
        let moves = state.game.position.allLegalMoves(for: .attacker)
        guard let move = moves.first else { return }
        let result = p2pGameReducer(state: state, action: .remoteMove(move))
        #expect(result.captureHistory.count == 1)
    }

    // MARK: - remoteMove with capture (countCapturesP2P)

    @Test("remoteMove counts attacker captures correctly")
    func remoteMove_countsAttackerCaptures() {
        // Build a custom position where an attacker move will capture a defender.
        // Place king at center, a defender at (3,5), attacker at (3,4).
        // Remote (attacker) moves attacker from (3,6) to (3,4) isn't a capture.
        // Better: defender at (3,5), attacker at (2,5), remote attacker moves from (4,5) to ...
        // Actually, let's set up a simple custodial capture:
        // Defender at (4,5), attackers at (3,5) and ... we move attacker from (5,7) to (5,5) to sandwich defender.
        // Simplest: defender at row=4 col=5, attacker already at row=3 col=5.
        // Remote attacker moves from row=5 col=0 to row=5 col=5 → captures defender at row=4 col=5.
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .build()
        let game = Game(position: pos, currentPlayer: .attacker, moveHistory: [])
        let session = PeerSessionState(
            isHost: true,
            localRole: Player.defender.roleString,
            connectionState: .connected
        )
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        // Attacker at (5,0) moves to (5,4) — but actually need to flank defender at (4,5).
        // Attacker needs to go to (5,5) but king is there. Let me revise:
        // Defender at (4,3), attacker at (3,3), remote attacker from (6,3) to (5,3) → captures at (4,3).
        let pos2 = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 3)
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 6, col: 3)
            .build()
        let game2 = Game(position: pos2, currentPlayer: .attacker, moveHistory: [])
        let state2 = GameState(
            game: game2,
            selectedSquare: nil,
            legalMovesForSelected: [],
            p2pSession: session
        )
        // Move attacker from (6,3) to (5,3) → defender at (4,3) sandwiched between (3,3) and (5,3)
        let captureMove = Move(fromRow: 6, fromCol: 3, toRow: 5, toCol: 3)
        let result = p2pGameReducer(state: state2, action: .remoteMove(captureMove))
        #expect(result.defendersCaptured == 1)
        #expect(result.attackersCaptured == 0)
    }

    // MARK: - peerConnected

    @Test("peerConnected sets remotePeerId and connectionState to connected")
    func peerConnected_setsFields() {
        let state = stateWithP2PSession(connectionState: .connecting, remotePeerId: nil)
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "new-peer"))
        #expect(result.p2pSession?.remotePeerId == "new-peer")
        #expect(result.p2pSession?.connectionState == .connected)
    }

    @Test("peerConnected is no-op without session")
    func peerConnected_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .peerConnected(peerId: "p"))
        #expect(result.p2pSession == nil)
    }

    // MARK: - peerDisconnected

    @Test("peerDisconnected sets connectionState to disconnected")
    func peerDisconnected_setsDisconnected() {
        let state = stateWithP2PSession(connectionState: .connected)
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession?.connectionState == .disconnected)
    }

    @Test("peerDisconnected is no-op without session")
    func peerDisconnected_noopWithoutSession() {
        let state = GameState()
        let result = p2pGameReducer(state: state, action: .peerDisconnected)
        #expect(result.p2pSession == nil)
    }

    // MARK: - syncState, connectionError, handshakeReceived, handshakeAccepted (pass-through)

    @Test("syncState returns state unchanged")
    func syncState_passthrough() {
        let state = stateWithP2PSession()
        let payload = GameStateSyncPayload(cells: [], currentPlayer: "attacker", moveHistory: [], variant: "copenhagen")
        let result = p2pGameReducer(state: state, action: .syncState(payload))
        #expect(result == state)
    }

    @Test("connectionError returns state unchanged")
    func connectionError_passthrough() {
        let state = stateWithP2PSession()
        let result = p2pGameReducer(state: state, action: .connectionError("timeout"))
        #expect(result == state)
    }

    @Test("handshakeReceived returns state unchanged")
    func handshakeReceived_passthrough() {
        let state = stateWithP2PSession()
        let handshake = PeerHandshake(protocolVersion: 1, variant: "copenhagen", playerName: nil)
        let result = p2pGameReducer(state: state, action: .handshakeReceived(handshake))
        #expect(result == state)
    }

    @Test("handshakeAccepted returns state unchanged")
    func handshakeAccepted_passthrough() {
        let state = stateWithP2PSession()
        let result = p2pGameReducer(state: state, action: .handshakeAccepted)
        #expect(result == state)
    }
}
