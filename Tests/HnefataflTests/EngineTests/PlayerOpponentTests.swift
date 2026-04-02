import Testing
@testable import Hnefatafl

@Suite("Player.opponent Tests")
struct PlayerOpponentTests {

    @Test("attacker opponent is defender")
    func attackerOpponent() {
        #expect(Player.attacker.opponent == .defender)
    }

    @Test("defender opponent is attacker")
    func defenderOpponent() {
        #expect(Player.defender.opponent == .attacker)
    }

    @Test("double opponent returns self")
    func doubleOpponentIsIdentity() {
        #expect(Player.attacker.opponent.opponent == .attacker)
        #expect(Player.defender.opponent.opponent == .defender)
    }
}
