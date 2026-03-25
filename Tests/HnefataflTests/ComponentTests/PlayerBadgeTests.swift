import Testing
@testable import Hnefatafl

@Suite("PlayerBadge Tests")
struct PlayerBadgeTests {

    @Test("attacker display name")
    func attackerDisplayName() {
        let badge = PlayerBadge(player: .attacker, isActive: true, captureCount: 0)
        #expect(badge.displayName == "Attacker")
    }

    @Test("defender display name")
    func defenderDisplayName() {
        let badge = PlayerBadge(player: .defender, isActive: false, captureCount: 3)
        #expect(badge.displayName == "Defender")
    }

    @Test("active status text")
    func activeStatusText() {
        let badge = PlayerBadge(player: .attacker, isActive: true, captureCount: 0)
        #expect(badge.statusText == "Your turn")
    }

    @Test("waiting status text")
    func waitingStatusText() {
        let badge = PlayerBadge(player: .defender, isActive: false, captureCount: 2)
        #expect(badge.statusText == "Waiting")
    }

    @Test("capture count stored correctly")
    func captureCount() {
        let badge = PlayerBadge(player: .attacker, isActive: true, captureCount: 5)
        #expect(badge.captureCount == 5)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = PlayerBadge(player: .attacker, isActive: true, captureCount: 2)
        let b = PlayerBadge(player: .attacker, isActive: true, captureCount: 2)
        let c = PlayerBadge(player: .attacker, isActive: false, captureCount: 2)
        #expect(a == b)
        #expect(a != c)
    }
}
