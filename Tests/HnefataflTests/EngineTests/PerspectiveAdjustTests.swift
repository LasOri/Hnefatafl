import Testing
@testable import Hnefatafl

@Suite("PerspectiveAdjust Tests")
struct PerspectiveAdjustTests {

    @Test("forAttackerPositive returns positive for attacker")
    func attackerPositiveForAttacker() {
        #expect(PerspectiveAdjust.forAttackerPositive(10, player: .attacker) == 10)
    }

    @Test("forAttackerPositive returns negative for defender")
    func attackerPositiveForDefender() {
        #expect(PerspectiveAdjust.forAttackerPositive(10, player: .defender) == -10)
    }

    @Test("forDefenderPositive returns negative for attacker")
    func defenderPositiveForAttacker() {
        #expect(PerspectiveAdjust.forDefenderPositive(10, player: .attacker) == -10)
    }

    @Test("forDefenderPositive returns positive for defender")
    func defenderPositiveForDefender() {
        #expect(PerspectiveAdjust.forDefenderPositive(10, player: .defender) == 10)
    }

    @Test("zero value unchanged for both perspectives")
    func zeroUnchanged() {
        #expect(PerspectiveAdjust.forAttackerPositive(0, player: .attacker) == 0)
        #expect(PerspectiveAdjust.forAttackerPositive(0, player: .defender) == 0)
        #expect(PerspectiveAdjust.forDefenderPositive(0, player: .attacker) == 0)
        #expect(PerspectiveAdjust.forDefenderPositive(0, player: .defender) == 0)
    }

    @Test("negative input handled correctly")
    func negativeInput() {
        #expect(PerspectiveAdjust.forAttackerPositive(-5, player: .attacker) == -5)
        #expect(PerspectiveAdjust.forAttackerPositive(-5, player: .defender) == 5)
        #expect(PerspectiveAdjust.forDefenderPositive(-5, player: .attacker) == 5)
        #expect(PerspectiveAdjust.forDefenderPositive(-5, player: .defender) == -5)
    }

    @Test("attacker and defender positive are inverse")
    func inverseRelationship() {
        let value = 42
        let atkPos = PerspectiveAdjust.forAttackerPositive(value, player: .attacker)
        let defPos = PerspectiveAdjust.forDefenderPositive(value, player: .attacker)
        #expect(atkPos == -defPos)
    }
}
