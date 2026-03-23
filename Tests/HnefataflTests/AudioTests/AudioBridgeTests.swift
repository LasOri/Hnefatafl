import Testing
@testable import Hnefatafl

@Suite("Sound Effect Tests")
struct SoundEffectTests {

    @Test("SoundEffect enum has move case")
    func soundEffect_hasMove() {
        let effect = SoundEffect.move
        #expect(effect == .move)
    }

    @Test("SoundEffect enum has capture case")
    func soundEffect_hasCapture() {
        let effect = SoundEffect.capture
        #expect(effect == .capture)
    }

    @Test("SoundEffect enum has gameOver case")
    func soundEffect_hasGameOver() {
        let effect = SoundEffect.gameOver
        #expect(effect == .gameOver)
    }

    @Test("SoundEffect enum has select case")
    func soundEffect_hasSelect() {
        let effect = SoundEffect.select
        #expect(effect == .select)
    }

    @Test("each sound effect has a filename")
    func soundEffect_hasFilename() {
        for effect in SoundEffect.allCases {
            #expect(!effect.filename.isEmpty)
        }
    }

    @Test("filenames are unique")
    func soundEffect_uniqueFilenames() {
        let filenames = SoundEffect.allCases.map(\.filename)
        #expect(Set(filenames).count == filenames.count)
    }
}

@Suite("AudioBridge Tests")
struct AudioBridgeTests {

    @Test("AudioBridge has play method")
    func audioBridge_hasPlayMethod() {
        let bridge = AudioBridge()
        bridge.play(.move)
    }

    @Test("AudioBridge tracks last played sound")
    func audioBridge_tracksLastPlayed() {
        let bridge = AudioBridge()
        bridge.play(.capture)

        #expect(bridge.lastPlayed == .capture)
    }

    @Test("AudioBridge mute prevents tracking")
    func audioBridge_muteStopsTracking() {
        let bridge = AudioBridge()
        bridge.muted = true
        bridge.play(.select)

        #expect(bridge.lastPlayed == nil)
    }
}
