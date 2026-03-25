import Testing
@testable import Hnefatafl

@Suite("GameRecordEntry Tests")
struct GameRecordEntryTests {

    @Test("attacker win detected")
    func attackerWin() {
        let entry = GameRecordEntry(moveCount: 50, result: .attackerWins, playerSide: .attacker, date: "2026-03-25")
        #expect(entry.isWin == true)
    }

    @Test("defender win detected")
    func defenderWin() {
        let entry = GameRecordEntry(moveCount: 30, result: .defenderWins, playerSide: .defender, date: "2026-03-25")
        #expect(entry.isWin == true)
    }

    @Test("loss when opponent wins")
    func lossDetected() {
        let entry = GameRecordEntry(moveCount: 40, result: .attackerWins, playerSide: .defender, date: "2026-03-25")
        #expect(entry.isWin == false)
    }

    @Test("draw is not a win")
    func drawNotWin() {
        let entry = GameRecordEntry(moveCount: 200, result: .draw, playerSide: .attacker, date: "2026-03-25")
        #expect(entry.isWin == false)
    }

    @Test("in-progress is not a win")
    func inProgressNotWin() {
        let entry = GameRecordEntry(moveCount: 10, result: .inProgress, playerSide: .defender, date: "2026-03-25")
        #expect(entry.isWin == false)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameRecordEntry(moveCount: 50, result: .attackerWins, playerSide: .attacker, date: "2026-03-25")
        let b = GameRecordEntry(moveCount: 50, result: .attackerWins, playerSide: .attacker, date: "2026-03-25")
        let c = GameRecordEntry(moveCount: 51, result: .attackerWins, playerSide: .attacker, date: "2026-03-25")
        #expect(a == b)
        #expect(a != c)
    }
}
