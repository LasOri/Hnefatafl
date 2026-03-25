import Testing
@testable import Hnefatafl

@Suite("GameClock Tests")
struct GameClockTests {

    @Test("initial clock has correct time for both players")
    func initialTime() {
        let clock = GameClock(initialSeconds: 600, incrementSeconds: 5)
        #expect(clock.remainingSeconds(for: .attacker) == 600)
        #expect(clock.remainingSeconds(for: .defender) == 600)
    }

    @Test("consuming time reduces remaining")
    func consumeTime() {
        var clock = GameClock(initialSeconds: 600, incrementSeconds: 0)
        clock.consumeTime(player: .attacker, seconds: 10)
        #expect(clock.remainingSeconds(for: .attacker) == 590)
        #expect(clock.remainingSeconds(for: .defender) == 600)
    }

    @Test("increment added after move")
    func incrementAdded() {
        var clock = GameClock(initialSeconds: 600, incrementSeconds: 5)
        clock.consumeTime(player: .attacker, seconds: 10)
        clock.addIncrement(player: .attacker)
        #expect(clock.remainingSeconds(for: .attacker) == 595)
    }

    @Test("flag detected when time reaches zero")
    func flagDetection() {
        var clock = GameClock(initialSeconds: 10, incrementSeconds: 0)
        clock.consumeTime(player: .attacker, seconds: 10)
        #expect(clock.isFlagged(player: .attacker))
        #expect(!clock.isFlagged(player: .defender))
    }

    @Test("time cannot go below zero")
    func noNegativeTime() {
        var clock = GameClock(initialSeconds: 5, incrementSeconds: 0)
        clock.consumeTime(player: .defender, seconds: 100)
        #expect(clock.remainingSeconds(for: .defender) == 0)
    }

    @Test("GameClock is Equatable")
    func equatable() {
        let a = GameClock(initialSeconds: 600, incrementSeconds: 5)
        let b = GameClock(initialSeconds: 600, incrementSeconds: 5)
        #expect(a == b)
    }

    @Test("both players can be flagged independently")
    func independentFlags() {
        var clock = GameClock(initialSeconds: 10, incrementSeconds: 0)
        clock.consumeTime(player: .attacker, seconds: 10)
        clock.consumeTime(player: .defender, seconds: 5)
        #expect(clock.isFlagged(player: .attacker))
        #expect(!clock.isFlagged(player: .defender))
    }

    @Test("totalElapsed tracks both players")
    func totalElapsed() {
        var clock = GameClock(initialSeconds: 600, incrementSeconds: 0)
        clock.consumeTime(player: .attacker, seconds: 10)
        clock.consumeTime(player: .defender, seconds: 15)
        #expect(clock.totalElapsed == 25)
    }
}
