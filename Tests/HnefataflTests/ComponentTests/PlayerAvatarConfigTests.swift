import Testing
@testable import Hnefatafl

@Suite("PlayerAvatarConfig Tests")
struct PlayerAvatarConfigTests {

    @Test("attacker default has correct name")
    func attackerDefaultName() {
        let config = PlayerAvatarConfig.defaultConfig(for: .attacker)
        #expect(config.name == "Attacker")
    }

    @Test("defender default has correct name")
    func defenderDefaultName() {
        let config = PlayerAvatarConfig.defaultConfig(for: .defender)
        #expect(config.name == "Defender")
    }

    @Test("attacker icon is sword")
    func attackerIcon() {
        let config = PlayerAvatarConfig.defaultConfig(for: .attacker)
        #expect(config.iconName == "sword")
    }

    @Test("defender icon is shield")
    func defenderIcon() {
        let config = PlayerAvatarConfig.defaultConfig(for: .defender)
        #expect(config.iconName == "shield")
    }

    @Test("player field matches input")
    func playerFieldMatches() {
        let attConfig = PlayerAvatarConfig.defaultConfig(for: .attacker)
        let defConfig = PlayerAvatarConfig.defaultConfig(for: .defender)
        #expect(attConfig.player == .attacker)
        #expect(defConfig.player == .defender)
    }

    @Test("equality works for identical configs")
    func equalityWorks() {
        let a = PlayerAvatarConfig(player: .attacker, name: "Test", iconName: "icon")
        let b = PlayerAvatarConfig(player: .attacker, name: "Test", iconName: "icon")
        #expect(a == b)
    }
}
