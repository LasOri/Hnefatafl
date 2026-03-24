import Testing
@testable import Hnefatafl

@Suite("Sound Library Tests")
struct SoundLibraryTests {

    @Test("every SoundEffect has a config")
    func allEffectsHaveConfig() {
        for effect in SoundEffect.allCases {
            let config = SoundLibrary.config(for: effect)
            #expect(config.frequency > 0)
            #expect(config.durationMs > 0)
        }
    }

    @Test("move sound uses sine wave")
    func moveSoundSine() {
        let config = SoundLibrary.config(for: .move)
        #expect(config.waveform == .sine)
    }

    @Test("capture sound uses square wave")
    func captureSoundSquare() {
        let config = SoundLibrary.config(for: .capture)
        #expect(config.waveform == .square)
    }

    @Test("gameOver sound has longer duration than move")
    func gameOverLongerThanMove() {
        let moveConfig = SoundLibrary.config(for: .move)
        let gameOverConfig = SoundLibrary.config(for: .gameOver)
        #expect(gameOverConfig.durationMs > moveConfig.durationMs)
    }

    @Test("select sound has higher frequency than move")
    func selectHigherThanMove() {
        let moveConfig = SoundLibrary.config(for: .move)
        let selectConfig = SoundLibrary.config(for: .select)
        #expect(selectConfig.frequency > moveConfig.frequency)
    }

    @Test("OscillatorWaveform has all four standard types")
    func waveformTypes() {
        let types: [OscillatorWaveform] = [.sine, .square, .sawtooth, .triangle]
        #expect(types.count == 4)
        for waveform in types {
            #expect(!waveform.rawValue.isEmpty)
        }
    }
}
