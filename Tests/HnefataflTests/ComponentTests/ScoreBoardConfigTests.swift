import Testing
@testable import Hnefatafl

@Suite("ScoreBoardConfig Tests")
struct ScoreBoardConfigTests {
    @Test("Standard preset shows all features")
    func standardPreset() {
        let config = ScoreBoardConfig.standard
        #expect(config.showMaterial == true)
        #expect(config.showEval == true)
        #expect(config.showClock == true)
        #expect(config.position == "top")
    }

    @Test("Minimal preset hides eval and clock")
    func minimalPreset() {
        let config = ScoreBoardConfig.minimal
        #expect(config.showMaterial == true)
        #expect(config.showEval == false)
        #expect(config.showClock == false)
    }

    @Test("Custom config stores position")
    func customPosition() {
        let config = ScoreBoardConfig(showMaterial: true, showEval: false, showClock: true, position: "bottom")
        #expect(config.position == "bottom")
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = ScoreBoardConfig(showMaterial: true, showEval: true, showClock: false, position: "left")
        let b = ScoreBoardConfig(showMaterial: true, showEval: true, showClock: false, position: "left")
        #expect(a == b)
    }

    @Test("Different configs are not equal")
    func notEqual() {
        let a = ScoreBoardConfig.standard
        let b = ScoreBoardConfig.minimal
        #expect(a != b)
    }

    @Test("All properties stored correctly")
    func allProperties() {
        let config = ScoreBoardConfig(showMaterial: false, showEval: true, showClock: false, position: "right")
        #expect(config.showMaterial == false)
        #expect(config.showEval == true)
        #expect(config.showClock == false)
        #expect(config.position == "right")
    }
}
