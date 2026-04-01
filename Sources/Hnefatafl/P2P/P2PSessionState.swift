import LINKER

struct P2PSessionState: Equatable {
    let isHost: Bool
    let localSide: Player?
    let remotePeerId: String?
    let connectionState: P2PConnectionState
    let localEndpointId: String?
    let variant: SelectedVariant
    let messageSequence: Int
    let lastReceivedSequence: Int

    init(
        isHost: Bool = false,
        localSide: Player? = nil,
        remotePeerId: String? = nil,
        connectionState: P2PConnectionState = .disconnected,
        localEndpointId: String? = nil,
        variant: SelectedVariant = .copenhagen,
        messageSequence: Int = 0,
        lastReceivedSequence: Int = 0
    ) {
        self.isHost = isHost
        self.localSide = localSide
        self.remotePeerId = remotePeerId
        self.connectionState = connectionState
        self.localEndpointId = localEndpointId
        self.variant = variant
        self.messageSequence = messageSequence
        self.lastReceivedSequence = lastReceivedSequence
    }

    func withConnectionState(_ state: P2PConnectionState) -> P2PSessionState {
        P2PSessionState(
            isHost: isHost,
            localSide: localSide,
            remotePeerId: remotePeerId,
            connectionState: state,
            localEndpointId: localEndpointId,
            variant: variant,
            messageSequence: messageSequence,
            lastReceivedSequence: lastReceivedSequence
        )
    }

    func withRemotePeer(_ peerId: String) -> P2PSessionState {
        P2PSessionState(
            isHost: isHost,
            localSide: localSide,
            remotePeerId: peerId,
            connectionState: connectionState,
            localEndpointId: localEndpointId,
            variant: variant,
            messageSequence: messageSequence,
            lastReceivedSequence: lastReceivedSequence
        )
    }

    func withLocalSide(_ side: Player) -> P2PSessionState {
        P2PSessionState(
            isHost: isHost,
            localSide: side,
            remotePeerId: remotePeerId,
            connectionState: connectionState,
            localEndpointId: localEndpointId,
            variant: variant,
            messageSequence: messageSequence,
            lastReceivedSequence: lastReceivedSequence
        )
    }

    func nextSequence() -> P2PSessionState {
        P2PSessionState(
            isHost: isHost,
            localSide: localSide,
            remotePeerId: remotePeerId,
            connectionState: connectionState,
            localEndpointId: localEndpointId,
            variant: variant,
            messageSequence: messageSequence + 1,
            lastReceivedSequence: lastReceivedSequence
        )
    }

    func withReceivedSequence(_ seq: Int) -> P2PSessionState {
        P2PSessionState(
            isHost: isHost,
            localSide: localSide,
            remotePeerId: remotePeerId,
            connectionState: connectionState,
            localEndpointId: localEndpointId,
            variant: variant,
            messageSequence: messageSequence,
            lastReceivedSequence: seq
        )
    }
}
