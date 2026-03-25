import Testing
@testable import Hnefatafl

@Suite("Resign Button Tests")
struct ResignButtonTests {

    @Test("unconfirmed action requires confirmation")
    func unconfirmedNeedsConfirmation() {
        let action = ResignButton.action(for: .attacker)
        #expect(action.confirmRequired)
    }

    @Test("confirmed action does not require confirmation")
    func confirmedNoConfirmation() {
        let action = ResignButton.action(for: .attacker, confirmed: true)
        #expect(!action.confirmRequired)
    }

    @Test("attacker resign message correct")
    func attackerResignMessage() {
        let action = ResignButton.action(for: .attacker, confirmed: true)
        #expect(action.message.contains("Attacker"))
    }

    @Test("defender resign message correct")
    func defenderResignMessage() {
        let action = ResignButton.action(for: .defender, confirmed: true)
        #expect(action.message.contains("Defender"))
    }

    @Test("player preserved in action")
    func playerPreserved() {
        let atkAction = ResignButton.action(for: .attacker)
        #expect(atkAction.player == .attacker)
        let defAction = ResignButton.action(for: .defender)
        #expect(defAction.player == .defender)
    }
}
