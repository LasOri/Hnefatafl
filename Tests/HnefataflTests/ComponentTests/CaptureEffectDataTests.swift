import Testing
@testable import Hnefatafl

@Suite("Capture Effect Data Tests")
struct CaptureEffectDataTests {

    @Test("isKingCapture true for king piece")
    func isKingCaptureTrue() {
        let effect = CaptureEffectData(row: 5, col: 5, piece: .king, effectType: "standard")
        #expect(effect.isKingCapture == true)
    }

    @Test("isKingCapture false for attacker")
    func isKingCaptureFalseAttacker() {
        let effect = CaptureEffectData(row: 3, col: 3, piece: .attacker, effectType: "standard")
        #expect(effect.isKingCapture == false)
    }

    @Test("isKingCapture false for defender")
    func isKingCaptureFalseDefender() {
        let effect = CaptureEffectData(row: 3, col: 3, piece: .defender, effectType: "standard")
        #expect(effect.isKingCapture == false)
    }

    @Test("standard factory sets effect type")
    func standardFactory() {
        let effect = CaptureEffectData.standard(row: 2, col: 4, piece: .attacker)
        #expect(effect.effectType == "standard")
        #expect(effect.row == 2)
        #expect(effect.col == 4)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = CaptureEffectData(row: 1, col: 2, piece: .defender, effectType: "flash")
        let b = CaptureEffectData(row: 1, col: 2, piece: .defender, effectType: "flash")
        #expect(a == b)
    }

    @Test("different effect types are not equal")
    func differentEffectType() {
        let a = CaptureEffectData(row: 1, col: 2, piece: .attacker, effectType: "standard")
        let b = CaptureEffectData(row: 1, col: 2, piece: .attacker, effectType: "flash")
        #expect(a != b)
    }
}
