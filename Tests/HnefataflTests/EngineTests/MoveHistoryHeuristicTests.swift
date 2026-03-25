import Testing
@testable import Hnefatafl

@Suite("MoveHistoryHeuristic Tests")
struct MoveHistoryHeuristicTests {

    @Test("empty heuristic returns zero")
    func emptyReturnsZero() {
        let heuristic = MoveHistoryHeuristic()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        #expect(heuristic.score(for: move) == 0)
    }

    @Test("record success increases score")
    func recordSuccessIncreases() {
        var heuristic = MoveHistoryHeuristic()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        heuristic.recordSuccess(move: move, depth: 3)
        #expect(heuristic.score(for: move) > 0)
    }

    @Test("depth squared weighting")
    func depthSquaredWeighting() {
        var heuristic = MoveHistoryHeuristic()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        heuristic.recordSuccess(move: move, depth: 4)
        #expect(heuristic.score(for: move) == 16)
    }

    @Test("age halves scores")
    func ageHalvesScores() {
        var heuristic = MoveHistoryHeuristic()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        heuristic.recordSuccess(move: move, depth: 4)
        let before = heuristic.score(for: move)
        heuristic.age()
        let after = heuristic.score(for: move)
        #expect(after == before / 2)
    }

    @Test("total entries tracks unique moves")
    func totalEntriesTracksUnique() {
        var heuristic = MoveHistoryHeuristic()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        heuristic.recordSuccess(move: m1, depth: 2)
        heuristic.recordSuccess(move: m2, depth: 3)
        #expect(heuristic.totalEntries == 2)
    }

    @Test("different moves have different keys")
    func differentMovesDifferentKeys() {
        var heuristic = MoveHistoryHeuristic()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        heuristic.recordSuccess(move: m1, depth: 3)
        #expect(heuristic.score(for: m1) > 0)
        #expect(heuristic.score(for: m2) == 0)
    }
}
