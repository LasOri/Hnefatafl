import LINKER

func p2pGameMiddleware() -> MiddlewareHandler<GameState> {
    var messageSequence = 0

    return { action, getState, dispatch, next in
        // First check if this is a P2PGameAction
        if let p2pGameAction = action.as(P2PGameAction.self) {
            next(action)
            handleP2PGameAction(p2pGameAction, getState: getState, dispatch: dispatch, sequence: &messageSequence)
            return
        }

        // Check if this is a GameAction.makeMove in P2P mode — serialize and send
        if let gameAction = action.as(GameAction.self) {
            if case .makeMove(let move) = gameAction {
                if let state = getState(), let session = state.p2pSession {
                    // Only allow move if it's local player's turn
                    guard isLocalPlayerTurn(state: state) else { return }

                    // Forward the action
                    next(action)

                    // Serialize and send the move
                    messageSequence += 1
                    let movePayload: Json = .object([
                        "fromRow": .int(move.fromRow),
                        "fromCol": .int(move.fromCol),
                        "toRow": .int(move.toRow),
                        "toCol": .int(move.toCol)
                    ])
                    let msg = P2PMessage(type: .move, payload: movePayload, sequence: messageSequence)
                    dispatch(AnyAction(P2PAction.send(key: session.remotePeerId ?? "default", data: msg.serialize())))
                    return
                }
            }
            next(action)
            return
        }

        // Check if this is a P2PAction.messageReceived — parse and dispatch game action
        if let p2pAction = action.as(P2PAction.self) {
            if case .messageReceived(_, let data) = p2pAction {
                next(action)
                handleIncomingMessage(data, dispatch: dispatch)
                return
            }
        }

        next(action)
    }
}

private func isLocalPlayerTurn(state: GameState) -> Bool {
    guard let session = state.p2pSession else { return true }
    guard let localSide = session.localSide else { return false }
    return state.game.currentPlayer == localSide
}

private func handleP2PGameAction(
    _ action: P2PGameAction,
    getState: @escaping () -> GameState?,
    dispatch: @escaping (AnyAction) -> Void,
    sequence: inout Int
) {
    switch action {
    case .hostGame(_):
        dispatch(AnyAction(P2PAction.initialize))
        break

    case .joinGame(let peerId):
        dispatch(AnyAction(P2PAction.initialize))
        dispatch(AnyAction(P2PAction.connect(peerId: peerId, key: peerId)))
        break

    case .leaveGame:
        dispatch(AnyAction(P2PAction.shutdown))
        sequence = 0
        break

    case .peerConnected:
        // Send handshake
        if let state = getState(), let session = state.p2pSession {
            sequence += 1
            let handshake = P2PHandshake(
                protocolVersion: P2PHandshake.currentVersion,
                variant: session.variant.rawValue,
                playerName: nil
            )
            let msg = P2PMessage(type: .handshake, payload: handshake.toJson(), sequence: sequence)
            dispatch(AnyAction(P2PAction.send(key: session.remotePeerId ?? "default", data: msg.serialize())))
        }

    default:
        break
    }
}

private func handleIncomingMessage(_ data: String, dispatch: @escaping (AnyAction) -> Void) {
    guard let msg = P2PMessage.deserialize(data) else { return }

    switch msg.type {
    case .move:
        guard let fromRow = msg.payload["fromRow"]?.intValue,
              let fromCol = msg.payload["fromCol"]?.intValue,
              let toRow = msg.payload["toRow"]?.intValue,
              let toCol = msg.payload["toCol"]?.intValue else { return }
        guard fromRow >= 0, fromRow < Position.boardSize,
              fromCol >= 0, fromCol < Position.boardSize,
              toRow >= 0, toRow < Position.boardSize,
              toCol >= 0, toCol < Position.boardSize else { return }
        let move = Move(fromRow: fromRow, fromCol: fromCol, toRow: toRow, toCol: toCol)
        dispatch(AnyAction(P2PGameAction.remoteMove(move)))

    case .handshake:
        if let handshake = P2PHandshake.fromJson(msg.payload) {
            dispatch(AnyAction(P2PGameAction.handshakeReceived(handshake)))
        }

    case .resign:
        dispatch(AnyAction(P2PGameAction.peerDisconnected))

    case .newGame:
        // Remote peer cannot unilaterally reset the game
        // Future: dispatch a confirmation request to the local user
        break

    case .ping:
        // Pong would need connection key to send; handled at higher level
        break

    default:
        break
    }
}
