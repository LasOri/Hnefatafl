import LINKER

func p2pGameReducer(state: GameState, action: P2PGameAction) -> GameState {
    switch action {
    case .hostGame(let variant):
        return reduceHostGame(state: state, variant: variant)
    case .joinGame(let peerId):
        return reduceJoinGame(state: state, peerId: peerId)
    case .leaveGame:
        return reduceLeaveGame(state: state)
    case .assignSide(let localSide):
        return reduceAssignSide(state: state, localSide: localSide)
    case .remoteMove(let move):
        return reduceRemoteMove(state: state, move: move)
    case .syncState:
        return state
    case .sessionUpdated(let session):
        return reduceSessionUpdated(state: state, session: session)
    case .peerConnected(let peerId):
        return reducePeerConnected(state: state, peerId: peerId)
    case .peerDisconnected:
        return reducePeerDisconnected(state: state)
    case .connectionError:
        return state
    case .handshakeReceived:
        return state
    case .handshakeAccepted:
        return state
    }
}

private func reduceHostGame(state: GameState, variant: SelectedVariant) -> GameState {
    let session = PeerSessionState(
        isHost: true,
        localRole: Player.defender.roleString,
        connectionState: .connecting,
        variant: variant.rawValue
    )
    let startPos = variant.startPosition
    let newGame = Game(position: startPos, currentPlayer: .attacker, moveHistory: [], positionHistory: [startPos])
    return GameState(
        game: newGame,
        selectedSquare: nil,
        legalMovesForSelected: [],
        muted: state.muted,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: variant,
        p2pSession: session,
        showP2PConnect: true
    )
}

private func reduceJoinGame(state: GameState, peerId: String) -> GameState {
    let session = PeerSessionState(
        isHost: false,
        localRole: Player.attacker.roleString,
        remotePeerId: peerId,
        connectionState: .connecting
    )
    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: session,
        showP2PConnect: true
    )
}

private func reduceSessionUpdated(state: GameState, session: PeerSessionState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: session,
        showP2PConnect: state.showP2PConnect
    )
}

private func reduceLeaveGame(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: nil,
        showP2PConnect: true
    )
}

private func reduceAssignSide(state: GameState, localSide: Player) -> GameState {
    guard let session = state.p2pSession else { return state }
    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: session.withLocalRole(localSide.roleString),
        showP2PConnect: state.showP2PConnect
    )
}

private func reduceRemoteMove(state: GameState, move: Move) -> GameState {
    guard let session = state.p2pSession else { return state }

    // Validate: it must be the remote player's turn
    guard let localRole = session.localRole,
          let localSide = Player.fromRole(localRole) else { return state }
    let remoteSide = localSide.opponent
    guard state.game.currentPlayer == remoteSide else { return state }

    // Validate move coordinates are in bounds
    guard move.fromRow >= 0, move.fromRow < Position.boardSize,
          move.fromCol >= 0, move.fromCol < Position.boardSize,
          move.toRow >= 0, move.toRow < Position.boardSize,
          move.toCol >= 0, move.toCol < Position.boardSize else {
        return state
    }

    // Validate move is legal
    let legalMoves = state.game.position.allLegalMoves(for: remoteSide)
    guard legalMoves.contains(move) else { return state }

    let newGame = state.game.makeMove(move)
    let captured = Position.capturedSquares(
        before: state.game.position,
        after: newGame.position,
        movedFrom: (row: move.fromRow, col: move.fromCol)
    )
    let (capturedAttackers, capturedDefenders) = countCapturesP2P(
        before: state.game.position, after: newGame.position
    )

    var newCaptureHistory = state.captureHistory
    newCaptureHistory.append(!captured.isEmpty)

    return GameState(
        game: newGame,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured + capturedAttackers,
        defendersCaptured: state.defendersCaptured + capturedDefenders,
        undoStack: state.undoStack,
        aiMode: state.aiMode,
        lastMove: move,
        capturedSquares: captured,
        muted: state.muted,
        captureHistory: newCaptureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: session.withReceivedSequence(session.lastReceivedSequence + 1),
        showP2PConnect: state.showP2PConnect
    )
}

private func reducePeerConnected(state: GameState, peerId: String) -> GameState {
    guard let session = state.p2pSession else { return state }
    let updated = session.withRemotePeer(peerId).withConnectionState(.connected)
    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: updated,
        showP2PConnect: state.showP2PConnect
    )
}

private func reducePeerDisconnected(state: GameState) -> GameState {
    guard let session = state.p2pSession else { return state }
    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        aiPersonality: state.aiPersonality,
        boardFlipped: state.boardFlipped,
        showCoordinates: state.showCoordinates,
        selectedVariant: state.selectedVariant,
        p2pSession: session.withConnectionState(.disconnected),
        showP2PConnect: state.showP2PConnect
    )
}

private func countCapturesP2P(before: Position, after: Position) -> (attackers: Int, defenders: Int) {
    let oldAttackers = before.cells.filter { $0 == .attacker }.count
    let newAttackers = after.cells.filter { $0 == .attacker }.count
    let oldDefenders = before.cells.filter { $0 == .defender || $0 == .king }.count
    let newDefenders = after.cells.filter { $0 == .defender || $0 == .king }.count
    return (oldAttackers - newAttackers, oldDefenders - newDefenders)
}
