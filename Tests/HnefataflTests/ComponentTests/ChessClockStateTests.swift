import Testing
@testable import Hnefatafl

@Suite("ChessClockState Tests")
struct ChessClockStateTests {

    @Test("tick decrements active player time")
    func tickDecrementsActive() {
        var state = ChessClockState(attackerTime: 300, defenderTime: 300, activePlayer: .attacker, isRunning: true)
        state.tick()
        #expect(state.attackerTime == 299)
        #expect(state.defenderTime == 300)
    }

    @Test("tick does nothing when not running")
    func tickNotRunning() {
        var state = ChessClockState(attackerTime: 300, defenderTime: 300, activePlayer: .attacker, isRunning: false)
        state.tick()
        #expect(state.attackerTime == 300)
    }

    @Test("switchPlayer toggles active player")
    func switchPlayerToggles() {
        var state = ChessClockState(attackerTime: 300, defenderTime: 300, activePlayer: .attacker, isRunning: true)
        state.switchPlayer()
        #expect(state.activePlayer == .defender)
    }

    @Test("isExpired when time reaches zero")
    func expiredAtZero() {
        let state = ChessClockState(attackerTime: 0, defenderTime: 300, activePlayer: .attacker, isRunning: true)
        #expect(state.isExpired)
    }

    @Test("not expired when both have time")
    func notExpired() {
        let state = ChessClockState(attackerTime: 100, defenderTime: 100, activePlayer: .attacker, isRunning: true)
        #expect(!state.isExpired)
    }
}
