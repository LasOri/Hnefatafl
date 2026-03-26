import Testing
@testable import Hnefatafl

@Suite("PositionDistance Tests")
struct PositionDistanceTests {

    @Test("same position has distance zero")
    func samePosition() {
        let pos = Position.copenhagenStart()
        #expect(PositionDistance.compute(posA: pos, posB: pos) == 0)
    }

    @Test("different positions have positive distance")
    func differentPositions() {
        let posA = Position.copenhagenStart()
        let moves = posA.allLegalMoves(for: .attacker)
        let posB = posA.applyMove(moves[0])
        #expect(PositionDistance.compute(posA: posA, posB: posB) > 0)
    }

    @Test("distance is symmetric")
    func symmetric() {
        let posA = Position.copenhagenStart()
        let moves = posA.allLegalMoves(for: .attacker)
        let posB = posA.applyMove(moves[0])
        let d1 = PositionDistance.compute(posA: posA, posB: posB)
        let d2 = PositionDistance.compute(posA: posB, posB: posA)
        #expect(d1 == d2)
    }

    @Test("more changes means larger distance")
    func moreChanges() {
        let posA = Position.copenhagenStart()
        let empty = Position(cells: Array(repeating: nil, count: 121))
        let moves = posA.allLegalMoves(for: .attacker)
        let posB = posA.applyMove(moves[0])
        let d1 = PositionDistance.compute(posA: posA, posB: posB)
        let d2 = PositionDistance.compute(posA: posA, posB: empty)
        #expect(d2 > d1)
    }

    @Test("empty vs empty is zero")
    func emptyVsEmpty() {
        let empty = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionDistance.compute(posA: empty, posB: empty) == 0)
    }

    @Test("normalize returns 0-1 range")
    func normalize() {
        let posA = Position.copenhagenStart()
        let moves = posA.allLegalMoves(for: .attacker)
        let posB = posA.applyMove(moves[0])
        let norm = PositionDistance.normalized(posA: posA, posB: posB)
        #expect(norm >= 0.0 && norm <= 1.0)
    }

    @Test("normalized same position is zero")
    func normalizedZero() {
        let pos = Position.copenhagenStart()
        #expect(PositionDistance.normalized(posA: pos, posB: pos) == 0.0)
    }
}
