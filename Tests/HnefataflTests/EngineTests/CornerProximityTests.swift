import Testing
@testable import Hnefatafl

@Suite("Corner Proximity Tests")
struct CornerProximityTests {

    @Test("king at corner has max proximity")
    func kingAtCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .king
        let position = Position(cells: cells)
        let score = CornerProximity.score(position: position)
        #expect(score == CornerProximity.maxScore)
    }

    @Test("king at center has low proximity")
    func kingAtCenter() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        let position = Position(cells: cells)
        let score = CornerProximity.score(position: position)
        #expect(score < CornerProximity.maxScore)
    }

    @Test("no king returns zero")
    func noKing() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let score = CornerProximity.score(position: position)
        #expect(score == 0)
    }

    @Test("closer to corner is higher score")
    func closerHigher() {
        var cells1: [Piece?] = Array(repeating: nil, count: 121)
        cells1[1] = .king
        let pos1 = Position(cells: cells1)

        var cells2: [Piece?] = Array(repeating: nil, count: 121)
        cells2[60] = .king
        let pos2 = Position(cells: cells2)

        #expect(CornerProximity.score(position: pos1) > CornerProximity.score(position: pos2))
    }

    @Test("max score constant")
    func maxScoreConstant() {
        #expect(CornerProximity.maxScore == 20)
    }

    @Test("nearest corner distance from center is 10")
    func centerDistance() {
        let dist = CornerProximity.nearestCornerDistance(row: 5, col: 5)
        #expect(dist == 10)
    }

    @Test("nearest corner distance from corner is 0")
    func cornerDistance() {
        let dist = CornerProximity.nearestCornerDistance(row: 0, col: 0)
        #expect(dist == 0)
    }

    @Test("score is non-negative")
    func nonNegative() {
        let position = Position.copenhagenStart()
        let score = CornerProximity.score(position: position)
        #expect(score >= 0)
    }
}
