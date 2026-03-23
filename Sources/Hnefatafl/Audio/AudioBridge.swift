enum SoundEffect: Equatable, CaseIterable {
    case move
    case capture
    case gameOver
    case select

    var filename: String {
        switch self {
        case .move: return "move.wav"
        case .capture: return "capture.wav"
        case .gameOver: return "gameover.wav"
        case .select: return "select.wav"
        }
    }
}

class AudioBridge {
    var muted = false
    private(set) var lastPlayed: SoundEffect?

    func play(_ effect: SoundEffect) {
        guard !muted else { return }
        lastPlayed = effect
    }

    func processState(_ state: GameState) {
        guard let effect = state.pendingSoundEffect else { return }
        play(effect)
    }
}
