class AudioSubscriber {
    let bridge = AudioBridge()

    func handleStateChange(_ state: GameState) {
        bridge.muted = state.muted
        bridge.processState(state)
    }
}
