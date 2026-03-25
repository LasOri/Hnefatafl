import Testing
@testable import Hnefatafl

@Suite("Settings Panel Tests")
struct SettingsPanelTests {

    @Test("default settings")
    func defaultSettings() {
        let settings = GameSettings()
        #expect(settings.soundEnabled == true)
        #expect(settings.animationsEnabled == true)
        #expect(settings.showCoordinates == true)
        #expect(settings.showLegalMoves == true)
        #expect(settings.confirmMoves == false)
    }

    @Test("toggle sound")
    func toggleSound() {
        var settings = GameSettings()
        settings.toggle(.sound)
        #expect(settings.soundEnabled == false)
        settings.toggle(.sound)
        #expect(settings.soundEnabled == true)
    }

    @Test("toggle animations")
    func toggleAnimations() {
        var settings = GameSettings()
        settings.toggle(.animations)
        #expect(settings.animationsEnabled == false)
    }

    @Test("toggle confirm moves")
    func toggleConfirmMoves() {
        var settings = GameSettings()
        settings.toggle(.confirmMoves)
        #expect(settings.confirmMoves == true)
    }

    @Test("setting key labels")
    func settingKeyLabels() {
        #expect(SettingKey.sound.label == "Sound")
        #expect(SettingKey.animations.label == "Animations")
        #expect(SettingKey.coordinates.label == "Coordinates")
        #expect(SettingKey.legalMoves.label == "Legal Moves")
        #expect(SettingKey.confirmMoves.label == "Confirm Moves")
    }

    @Test("all cases count")
    func allCasesCount() {
        #expect(SettingKey.allCases.count == 5)
    }
}
