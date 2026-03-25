import Testing
@testable import Hnefatafl

@Suite("Player Label Tests")
struct PlayerLabelTests {

    @Test("attacker name is Attacker")
    func attackerName() {
        #expect(PlayerLabel.name(for: .attacker) == "Attacker")
    }

    @Test("defender name is Defender")
    func defenderName() {
        #expect(PlayerLabel.name(for: .defender) == "Defender")
    }

    @Test("attacker icon is sword")
    func attackerIcon() {
        #expect(PlayerLabel.icon(for: .attacker) == "sword")
    }

    @Test("defender icon is shield")
    func defenderIcon() {
        #expect(PlayerLabel.icon(for: .defender) == "shield")
    }

    @Test("colors are valid hex strings")
    func validHexColors() {
        #expect(PlayerLabel.color(for: .attacker).hasPrefix("#"))
        #expect(PlayerLabel.color(for: .defender).hasPrefix("#"))
    }
}
