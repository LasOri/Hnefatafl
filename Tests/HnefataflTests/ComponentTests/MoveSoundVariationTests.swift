import Testing
@testable import Hnefatafl

@Suite("Move Sound Variation Tests")
struct MoveSoundVariationTests {

    @Test("regular move has sound")
    func regularSound() {
        let sound = MoveSoundVariation.sound(for: .regular)
        #expect(!sound.isEmpty)
    }

    @Test("capture move has distinct sound")
    func captureSound() {
        let regular = MoveSoundVariation.sound(for: .regular)
        let capture = MoveSoundVariation.sound(for: .capture)
        #expect(regular != capture)
    }

    @Test("king escape has victory sound")
    func kingEscapeSound() {
        let sound = MoveSoundVariation.sound(for: .kingEscape)
        #expect(sound.contains("victory"))
    }

    @Test("check has alert sound")
    func checkSound() {
        let sound = MoveSoundVariation.sound(for: .check)
        #expect(sound.contains("alert"))
    }

    @Test("all move types have sounds")
    func allTypesHaveSounds() {
        let types: [MoveType] = [.regular, .capture, .kingEscape, .check, .aggressive, .defensive]
        for type in types {
            #expect(!MoveSoundVariation.sound(for: type).isEmpty)
        }
    }

    @Test("sound volume for regular move")
    func regularVolume() {
        let volume = MoveSoundVariation.volume(for: .regular)
        #expect(volume >= 0.0 && volume <= 1.0)
    }

    @Test("capture volume louder than regular")
    func captureVolumeLouder() {
        let regular = MoveSoundVariation.volume(for: .regular)
        let capture = MoveSoundVariation.volume(for: .capture)
        #expect(capture > regular)
    }

    @Test("SoundVariant has name and volume")
    func soundVariantProperties() {
        let effect = SoundVariant(name: "click", volume: 0.8)
        #expect(effect.name == "click")
        #expect(effect.volume == 0.8)
    }
}
