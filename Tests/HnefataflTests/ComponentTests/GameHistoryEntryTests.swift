import Testing
@testable import Hnefatafl

@Suite("GameHistoryEntry Tests")
struct GameHistoryEntryTests {

    @Test("result text for attacker wins")
    func attackerWinsText() {
        let entry = GameHistoryEntry(id: 1, date: "2026-03-25", moveCount: 40, result: .attackerWins, playerSide: .attacker)
        #expect(entry.resultText == "Attacker Wins")
    }

    @Test("result text for defender wins")
    func defenderWinsText() {
        let entry = GameHistoryEntry(id: 2, date: "2026-03-25", moveCount: 30, result: .defenderWins, playerSide: .defender)
        #expect(entry.resultText == "Defender Wins")
    }

    @Test("result text for draw")
    func drawText() {
        let entry = GameHistoryEntry(id: 3, date: "2026-03-25", moveCount: 50, result: .draw, playerSide: .attacker)
        #expect(entry.resultText == "Draw")
    }

    @Test("result text for in progress")
    func inProgressText() {
        let entry = GameHistoryEntry(id: 4, date: "2026-03-25", moveCount: 10, result: .inProgress, playerSide: .defender)
        #expect(entry.resultText == "In Progress")
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameHistoryEntry(id: 1, date: "2026-03-25", moveCount: 40, result: .attackerWins, playerSide: .attacker)
        let b = GameHistoryEntry(id: 1, date: "2026-03-25", moveCount: 40, result: .attackerWins, playerSide: .attacker)
        #expect(a == b)
    }

    @Test("inequal when different id")
    func inequalId() {
        let a = GameHistoryEntry(id: 1, date: "2026-03-25", moveCount: 40, result: .attackerWins, playerSide: .attacker)
        let b = GameHistoryEntry(id: 2, date: "2026-03-25", moveCount: 40, result: .attackerWins, playerSide: .attacker)
        #expect(a != b)
    }
}
