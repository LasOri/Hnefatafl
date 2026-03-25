import Testing
@testable import Hnefatafl

@Suite("Game Rules Config Tests")
struct GameRulesConfigTests {

    @Test("copenhagen preset has correct variant")
    func copenhagenVariant() {
        #expect(GameRulesConfig.copenhagen.variant == .copenhagen)
    }

    @Test("copenhagen preset has board size 11")
    func copenhagenBoardSize() {
        #expect(GameRulesConfig.copenhagen.boardSize == 11)
    }

    @Test("copenhagen preset has shield wall capture enabled")
    func copenhagenShieldWall() {
        #expect(GameRulesConfig.copenhagen.shieldWallCapture == true)
    }

    @Test("RulesVariant has all expected cases")
    func allVariants() {
        let all = RulesVariant.allCases
        #expect(all.contains(.copenhagen))
        #expect(all.contains(.hnefatafl))
        #expect(all.contains(.tablut))
        #expect(all.contains(.brandubh))
        #expect(all.count == 4)
    }

    @Test("configs are equatable")
    func equatable() {
        let a = GameRulesConfig.copenhagen
        let b = GameRulesConfig(variant: .copenhagen, boardSize: 11, shieldWallCapture: true)
        #expect(a == b)
    }

    @Test("custom config differs from copenhagen")
    func customDiffers() {
        let custom = GameRulesConfig(variant: .tablut, boardSize: 9, shieldWallCapture: false)
        #expect(custom != GameRulesConfig.copenhagen)
    }

    @Test("variant raw values are strings")
    func variantRawValues() {
        #expect(RulesVariant.copenhagen.rawValue == "copenhagen")
        #expect(RulesVariant.brandubh.rawValue == "brandubh")
    }
}
