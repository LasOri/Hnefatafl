import Testing
@testable import Hnefatafl

@Suite("Game Export Data Tests")
struct GameExportDataTests {

    @Test("moveCount reflects moves array length")
    func moveCountReflectsLength() {
        let data = GameExportData(
            moves: [
                Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2),
                Move(fromRow: 5, fromCol: 3, toRow: 3, toCol: 3)
            ],
            result: .inProgress,
            date: "2026-03-25"
        )
        #expect(data.moveCount == 2)
    }

    @Test("empty moves has zero moveCount")
    func emptyMovesZero() {
        let data = GameExportData(moves: [], result: .draw, date: "2026-03-25")
        #expect(data.moveCount == 0)
    }

    @Test("result is stored correctly")
    func resultStored() {
        let data = GameExportData(moves: [], result: .attackerWins, date: "2026-03-25")
        #expect(data.result == .attackerWins)
    }

    @Test("date is stored correctly")
    func dateStored() {
        let data = GameExportData(moves: [], result: .inProgress, date: "2026-01-01")
        #expect(data.date == "2026-01-01")
    }

    @Test("equatable with same values")
    func equatableSame() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)
        let a = GameExportData(moves: [move], result: .defenderWins, date: "2026-03-25")
        let b = GameExportData(moves: [move], result: .defenderWins, date: "2026-03-25")
        #expect(a == b)
    }

    @Test("not equal with different result")
    func notEqualDifferentResult() {
        let a = GameExportData(moves: [], result: .attackerWins, date: "2026-03-25")
        let b = GameExportData(moves: [], result: .defenderWins, date: "2026-03-25")
        #expect(a != b)
    }
}
