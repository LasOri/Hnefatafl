import Testing
@testable import Hnefatafl

@Suite("PlayerTimerData Tests")
struct PlayerTimerDataTests {
    @Test("Formatted time for full minutes")
    func formattedTimeMinutes() {
        let timer = PlayerTimerData(player: .attacker, remainingSeconds: 300.0, isRunning: true)
        #expect(timer.formattedTime == "5:00")
    }

    @Test("Formatted time with seconds")
    func formattedTimeWithSeconds() {
        let timer = PlayerTimerData(player: .defender, remainingSeconds: 125.0, isRunning: false)
        #expect(timer.formattedTime == "2:05")
    }

    @Test("Is low when under 60 seconds")
    func isLowUnder60() {
        let timer = PlayerTimerData(player: .attacker, remainingSeconds: 30.0, isRunning: true)
        #expect(timer.isLow == true)
    }

    @Test("Is not low when over 60 seconds")
    func notLowOver60() {
        let timer = PlayerTimerData(player: .defender, remainingSeconds: 120.0, isRunning: false)
        #expect(timer.isLow == false)
    }

    @Test("Zero seconds formatted correctly")
    func zeroSeconds() {
        let timer = PlayerTimerData(player: .attacker, remainingSeconds: 0.0, isRunning: false)
        #expect(timer.formattedTime == "0:00")
        #expect(timer.isLow == true)
    }

    @Test("Player property stored correctly")
    func playerProperty() {
        let attackerTimer = PlayerTimerData(player: .attacker, remainingSeconds: 100.0, isRunning: true)
        let defenderTimer = PlayerTimerData(player: .defender, remainingSeconds: 100.0, isRunning: false)
        #expect(attackerTimer.player == .attacker)
        #expect(defenderTimer.player == .defender)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = PlayerTimerData(player: .attacker, remainingSeconds: 60.0, isRunning: true)
        let b = PlayerTimerData(player: .attacker, remainingSeconds: 60.0, isRunning: true)
        let c = PlayerTimerData(player: .attacker, remainingSeconds: 30.0, isRunning: true)
        #expect(a == b)
        #expect(a != c)
    }
}
