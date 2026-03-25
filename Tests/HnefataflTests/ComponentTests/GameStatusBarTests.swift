import Testing
@testable import Hnefatafl

@Suite("GameStatusBar Tests")
struct GameStatusBarTests {

    @Test("in progress attacker turn shows attacker text")
    func inProgressAttacker() {
        let bar = GameStatusBar.forState(player: .attacker, status: .inProgress)
        #expect(bar.text == "Attacker's move")
        #expect(bar.isUrgent == false)
        #expect(bar.showTimer == true)
    }

    @Test("in progress defender turn shows defender text")
    func inProgressDefender() {
        let bar = GameStatusBar.forState(player: .defender, status: .inProgress)
        #expect(bar.text == "Defender's move")
    }

    @Test("attacker wins is urgent")
    func attackerWinsUrgent() {
        let bar = GameStatusBar.forState(player: .attacker, status: .attackerWins)
        #expect(bar.text == "Attackers win!")
        #expect(bar.isUrgent == true)
        #expect(bar.showTimer == false)
    }

    @Test("defender wins is urgent")
    func defenderWinsUrgent() {
        let bar = GameStatusBar.forState(player: .defender, status: .defenderWins)
        #expect(bar.text == "Defenders win!")
        #expect(bar.isUrgent == true)
    }

    @Test("draw is not urgent")
    func drawNotUrgent() {
        let bar = GameStatusBar.forState(player: .attacker, status: .draw)
        #expect(bar.text == "Game drawn")
        #expect(bar.isUrgent == false)
        #expect(bar.showTimer == false)
    }

    @Test("equatable conformance works")
    func equatable() {
        let a = GameStatusBar(text: "Test", isUrgent: false, showTimer: true)
        let b = GameStatusBar(text: "Test", isUrgent: false, showTimer: true)
        #expect(a == b)
    }
}
