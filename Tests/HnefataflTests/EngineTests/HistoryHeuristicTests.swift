import Testing
@testable import Hnefatafl

@Suite("History Heuristic Tests")
struct HistoryHeuristicTests {

    @Test("initial score is zero")
    func initialZero() {
        let table = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        #expect(table.score(for: move) == 0)
    }

    @Test("recording increases score")
    func recordIncreases() {
        var table = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.record(move: move, depth: 3)
        #expect(table.score(for: move) > 0)
    }

    @Test("deeper depth gives higher score")
    func deeperHigher() {
        var table1 = HistoryTable()
        var table2 = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table1.record(move: move, depth: 2)
        table2.record(move: move, depth: 5)
        #expect(table2.score(for: move) > table1.score(for: move))
    }

    @Test("multiple records accumulate")
    func accumulate() {
        var table = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.record(move: move, depth: 2)
        let first = table.score(for: move)
        table.record(move: move, depth: 2)
        #expect(table.score(for: move) > first)
    }

    @Test("different moves have independent scores")
    func independent() {
        var table = HistoryTable()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        table.record(move: m1, depth: 3)
        #expect(table.score(for: m1) > 0)
        #expect(table.score(for: m2) == 0)
    }

    @Test("clear resets all scores")
    func clear() {
        var table = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.record(move: move, depth: 3)
        table.clear()
        #expect(table.score(for: move) == 0)
    }

    @Test("sort moves by history score")
    func sortMoves() {
        var table = HistoryTable()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        table.record(move: m2, depth: 5)
        let sorted = table.sorted(moves: [m1, m2])
        #expect(sorted.first == m2)
    }

    @Test("score uses depth squared")
    func depthSquared() {
        var table = HistoryTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.record(move: move, depth: 4)
        #expect(table.score(for: move) == 16)
    }
}
