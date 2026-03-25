import Testing
@testable import Hnefatafl

@Suite("Victory Screen Tests")
struct VictoryScreenTests {

    @Test("attacker win message")
    func attackerWinMessage() {
        let data = VictoryScreen.data(winner: .attacker, method: .capture, moveCount: 42)
        #expect(data.message == "Attackers win by King Captured!")
    }

    @Test("defender win message")
    func defenderWinMessage() {
        let data = VictoryScreen.data(winner: .defender, method: .escape, moveCount: 30)
        #expect(data.message == "Defenders win by King Escaped!")
    }

    @Test("escape method preserved")
    func escapeMethod() {
        let data = VictoryScreen.data(winner: .defender, method: .escape, moveCount: 10)
        #expect(data.method == .escape)
    }

    @Test("capture method preserved")
    func captureMethod() {
        let data = VictoryScreen.data(winner: .attacker, method: .capture, moveCount: 10)
        #expect(data.method == .capture)
    }

    @Test("move count preserved")
    func moveCountPreserved() {
        let data = VictoryScreen.data(winner: .attacker, method: .resignation, moveCount: 99)
        #expect(data.totalMoves == 99)
    }
}
