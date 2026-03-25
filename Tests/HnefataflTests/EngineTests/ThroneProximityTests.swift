import Testing
@testable import Hnefatafl

@Suite("ThroneProximity Tests")
struct ThroneProximityTests {

    @Test("throne distance to itself is zero")
    func throneDistanceZero() {
        let dist = ThroneProximity.distanceToThrone(row: 5, col: 5)
        #expect(dist == 0)
    }

    @Test("corner distance to throne is 10")
    func cornerDistanceTen() {
        let dist = ThroneProximity.distanceToThrone(row: 0, col: 0)
        #expect(dist == 10)
    }

    @Test("adjacent square distance is 1")
    func adjacentDistance() {
        let dist = ThroneProximity.distanceToThrone(row: 5, col: 6)
        #expect(dist == 1)
    }

    @Test("throne control score is non-zero at start")
    func startPositionNonZero() {
        let pos = Position.copenhagenStart()
        let score = ThroneProximity.throneControlScore(position: pos)
        #expect(score != 0)
    }

    @Test("empty board throne control score is zero")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = ThroneProximity.throneControlScore(position: pos)
        #expect(score == 0)
    }

    @Test("defenders near center give positive score")
    func defendersNearCenterPositive() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .defender
        cells[4 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        let score = ThroneProximity.throneControlScore(position: pos)
        #expect(score > 0)
    }

    @Test("distance is symmetric")
    func symmetricDistance() {
        let a = ThroneProximity.distanceToThrone(row: 3, col: 7)
        let b = ThroneProximity.distanceToThrone(row: 7, col: 3)
        #expect(a == b)
    }
}
