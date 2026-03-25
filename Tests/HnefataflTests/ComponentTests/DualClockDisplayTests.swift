import Testing
@testable import Hnefatafl

@Suite("Dual Clock Display Tests")
struct DualClockDisplayTests {

    @Test("attacker time formats correctly")
    func attackerFormatted() {
        let clock = DualClockDisplay(attackerTime: 125, defenderTime: 300, activePlayer: .attacker)
        #expect(clock.attackerFormatted == "2:05")
    }

    @Test("defender time formats correctly")
    func defenderFormatted() {
        let clock = DualClockDisplay(attackerTime: 300, defenderTime: 65, activePlayer: .defender)
        #expect(clock.defenderFormatted == "1:05")
    }

    @Test("isLowTime true when attacker below 30")
    func lowTimeAttacker() {
        let clock = DualClockDisplay(attackerTime: 20, defenderTime: 300, activePlayer: .attacker)
        #expect(clock.isLowTime == true)
    }

    @Test("isLowTime true when defender below 30")
    func lowTimeDefender() {
        let clock = DualClockDisplay(attackerTime: 300, defenderTime: 10, activePlayer: .attacker)
        #expect(clock.isLowTime == true)
    }

    @Test("isLowTime false when both above 30")
    func notLowTime() {
        let clock = DualClockDisplay(attackerTime: 300, defenderTime: 300, activePlayer: .attacker)
        #expect(clock.isLowTime == false)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = DualClockDisplay(attackerTime: 100, defenderTime: 200, activePlayer: .attacker)
        let b = DualClockDisplay(attackerTime: 100, defenderTime: 200, activePlayer: .attacker)
        #expect(a == b)
    }

    @Test("zero seconds formats as 0:00")
    func zeroSeconds() {
        let clock = DualClockDisplay(attackerTime: 0, defenderTime: 0, activePlayer: .defender)
        #expect(clock.attackerFormatted == "0:00")
    }
}
