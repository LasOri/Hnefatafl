import Testing
@testable import Hnefatafl

@Suite("MoveFrequency Tests")
struct MoveFrequencyTests {

    @Test("empty tracker has no entries")
    func empty() {
        let tracker = MoveFrequencyTracker()
        #expect(tracker.totalMoves == 0)
    }

    @Test("record move increases count")
    func recordMove() {
        var tracker = MoveFrequencyTracker()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        tracker.record(move: move)
        #expect(tracker.totalMoves == 1)
        #expect(tracker.frequency(of: move) == 1)
    }

    @Test("same move recorded multiple times")
    func duplicateMove() {
        var tracker = MoveFrequencyTracker()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        tracker.record(move: move)
        tracker.record(move: move)
        tracker.record(move: move)
        #expect(tracker.frequency(of: move) == 3)
    }

    @Test("most frequent move")
    func mostFrequent() {
        var tracker = MoveFrequencyTracker()
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let move2 = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 5)
        tracker.record(move: move1)
        tracker.record(move: move1)
        tracker.record(move: move2)
        #expect(tracker.mostFrequent?.move == move1)
    }

    @Test("frequency of unrecorded move is zero")
    func unrecordedMove() {
        let tracker = MoveFrequencyTracker()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        #expect(tracker.frequency(of: move) == 0)
    }

    @Test("uniqueMoveCount tracks distinct moves")
    func uniqueCount() {
        var tracker = MoveFrequencyTracker()
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let move2 = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 5)
        tracker.record(move: move1)
        tracker.record(move: move1)
        tracker.record(move: move2)
        #expect(tracker.uniqueMoveCount == 2)
    }

    @Test("clear resets tracker")
    func clear() {
        var tracker = MoveFrequencyTracker()
        tracker.record(move: Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1))
        tracker.clear()
        #expect(tracker.totalMoves == 0)
        #expect(tracker.uniqueMoveCount == 0)
    }

    @Test("topMoves returns sorted by frequency")
    func topMoves() {
        var tracker = MoveFrequencyTracker()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let m2 = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 1)
        let m3 = Move(fromRow: 2, fromCol: 0, toRow: 2, toCol: 1)
        tracker.record(move: m1)
        tracker.record(move: m2)
        tracker.record(move: m2)
        tracker.record(move: m3)
        tracker.record(move: m3)
        tracker.record(move: m3)
        let top = tracker.topMoves(count: 2)
        #expect(top.count == 2)
        #expect(top[0].move == m3)
        #expect(top[1].move == m2)
    }
}
