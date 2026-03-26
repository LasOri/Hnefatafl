import Testing
@testable import Hnefatafl

@Suite("PositionComparator Tests")
struct PositionComparatorTests {

    @Test("same position has no differences")
    func samePosition() {
        let pos = Position.copenhagenStart()
        let result = PositionComparator.compare(posA: pos, posB: pos)
        #expect(result.changedSquares == 0)
        #expect(result.isIdentical)
    }

    @Test("different positions have differences")
    func different() {
        let posA = Position.copenhagenStart()
        let moves = posA.allLegalMoves(for: .attacker)
        let posB = posA.applyMove(moves[0])
        let result = PositionComparator.compare(posA: posA, posB: posB)
        #expect(result.changedSquares > 0)
        #expect(!result.isIdentical)
    }

    @Test("material difference tracked")
    func materialDiff() {
        let posA = Position.copenhagenStart()
        let posB = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let result = PositionComparator.compare(posA: posA, posB: posB)
        #expect(result.attackerDiff != 0)
    }

    @Test("PositionComparisonResult is Equatable")
    func equatable() {
        let a = PositionComparisonResult(changedSquares: 0, attackerDiff: 0, defenderDiff: 0, isIdentical: true, summary: "Same")
        let b = PositionComparisonResult(changedSquares: 0, attackerDiff: 0, defenderDiff: 0, isIdentical: true, summary: "Same")
        #expect(a == b)
    }

    @Test("summary text is non-empty")
    func summary() {
        let pos = Position.copenhagenStart()
        let result = PositionComparator.compare(posA: pos, posB: pos)
        #expect(!result.summary.isEmpty)
    }

    @Test("empty vs full board shows max difference")
    func emptyVsFull() {
        let empty = Position(cells: Array(repeating: nil, count: 121))
        let full = Position.copenhagenStart()
        let result = PositionComparator.compare(posA: empty, posB: full)
        #expect(result.changedSquares == 37)
    }
}
