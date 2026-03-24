enum OscillatorWaveform: String {
    case sine
    case square
    case sawtooth
    case triangle
}

struct OscillatorConfig: Equatable {
    let frequency: Double
    let durationMs: Int
    let waveform: OscillatorWaveform
    let gain: Double
}

struct SoundLibrary {
    static func config(for effect: SoundEffect) -> OscillatorConfig {
        switch effect {
        case .move:
            return OscillatorConfig(frequency: 440, durationMs: 100, waveform: .sine, gain: 0.3)
        case .capture:
            return OscillatorConfig(frequency: 220, durationMs: 150, waveform: .square, gain: 0.4)
        case .gameOver:
            return OscillatorConfig(frequency: 330, durationMs: 500, waveform: .sawtooth, gain: 0.5)
        case .select:
            return OscillatorConfig(frequency: 660, durationMs: 50, waveform: .sine, gain: 0.2)
        }
    }
}
