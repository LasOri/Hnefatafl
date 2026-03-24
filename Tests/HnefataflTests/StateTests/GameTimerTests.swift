import Testing
@testable import Hnefatafl

@Suite("Game Timer Tests")
struct GameTimerTests {

    @Test("TimerConfig presets have correct durations")
    func presets() {
        #expect(TimerConfig.blitz.secondsPerSide == 300)
        #expect(TimerConfig.standard.secondsPerSide == 900)
        #expect(TimerConfig.none.secondsPerSide == 0)
    }

    @Test("GameTimer initializes with equal time for both sides")
    func initializes() {
        let timer = GameTimer(config: .standard)
        #expect(timer.attackerSeconds == 900)
        #expect(timer.defenderSeconds == 900)
    }

    @Test("GameTimer tick decrements active player time")
    func tickDecrements() {
        let timer = GameTimer(config: .blitz)
        let ticked = timer.tick(activePlayer: .attacker)
        #expect(ticked.attackerSeconds == 299)
        #expect(ticked.defenderSeconds == 300)
    }

    @Test("GameTimer tick does not go below zero")
    func tickFloor() {
        let timer = GameTimer(config: .blitz, attackerSeconds: 0, defenderSeconds: 300)
        let ticked = timer.tick(activePlayer: .attacker)
        #expect(ticked.attackerSeconds == 0)
    }

    @Test("GameTimer detects timeout")
    func detectsTimeout() {
        let timer = GameTimer(config: .blitz, attackerSeconds: 0, defenderSeconds: 300)
        #expect(timer.isTimedOut(player: .attacker) == true)
        #expect(timer.isTimedOut(player: .defender) == false)
    }

    @Test("GameTimer disabled when config is none")
    func disabledWithNone() {
        let timer = GameTimer(config: .none)
        #expect(timer.isEnabled == false)
        let standard = GameTimer(config: .standard)
        #expect(standard.isEnabled == true)
    }

    @Test("GameTimer formatTime produces mm:ss")
    func formatTime() {
        #expect(GameTimer.formatTime(seconds: 65) == "1:05")
        #expect(GameTimer.formatTime(seconds: 0) == "0:00")
        #expect(GameTimer.formatTime(seconds: 3600) == "60:00")
    }

    @Test("TimerConfig labels are correct")
    func labels() {
        #expect(TimerConfig.blitz.label == "5 min")
        #expect(TimerConfig.standard.label == "15 min")
        #expect(TimerConfig.none.label == "No Timer")
    }
}
