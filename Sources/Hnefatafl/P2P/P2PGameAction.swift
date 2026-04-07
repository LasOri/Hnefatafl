import LINKER

enum P2PGameAction: Action {
    case hostGame(variant: SelectedVariant)
    case joinGame(peerId: String)
    case leaveGame

    case assignSide(localSide: Player)
    case remoteMove(Move)
    case syncState(GameStateSyncPayload)
    case sessionUpdated(PeerSessionState)

    case peerConnected(peerId: String)
    case peerDisconnected
    case connectionError(String)

    case handshakeReceived(PeerHandshake)
    case handshakeAccepted
}
