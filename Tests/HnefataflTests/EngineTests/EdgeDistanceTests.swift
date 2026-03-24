import Testing
@testable import Hnefatafl

@Suite("Edge Distance Tests")
struct EdgeDistanceTests {

    @Test("center square has max edge distance")
    func centerSquare() {
        let dist = EdgeDistance.toEdge(row: 5, col: 5)
        #expect(dist == 5)
    }

    @Test("corner has zero edge distance")
    func corner() {
        let dist = EdgeDistance.toEdge(row: 0, col: 0)
        #expect(dist == 0)
    }

    @Test("edge square has zero distance")
    func edgeSquare() {
        let dist = EdgeDistance.toEdge(row: 0, col: 5)
        #expect(dist == 0)
    }

    @Test("corner distance from center")
    func cornerFromCenter() {
        let dist = EdgeDistance.toCorner(row: 5, col: 5)
        #expect(dist == 10)
    }

    @Test("corner distance from corner is zero")
    func cornerFromCorner() {
        let dist = EdgeDistance.toCorner(row: 0, col: 0)
        #expect(dist == 0)
    }

    @Test("nearest corner identifies correct corner")
    func nearestCorner() {
        let corner = EdgeDistance.nearestCorner(row: 1, col: 1)
        #expect(corner.row == 0)
        #expect(corner.col == 0)
    }

    @Test("nearest corner for center")
    func nearestCornerCenter() {
        let corner = EdgeDistance.nearestCorner(row: 5, col: 5)
        #expect(corner.row == 0 || corner.row == 10)
    }

    @Test("king escape distance")
    func kingEscapeDistance() {
        let dist = EdgeDistance.kingEscapeDistance(row: 5, col: 5)
        #expect(dist == 10)
    }

    @Test("king at corner has zero escape distance")
    func kingAtCorner() {
        let dist = EdgeDistance.kingEscapeDistance(row: 0, col: 0)
        #expect(dist == 0)
    }

    @Test("edge distance is symmetric")
    func symmetric() {
        let a = EdgeDistance.toEdge(row: 2, col: 3)
        let b = EdgeDistance.toEdge(row: 8, col: 7)
        #expect(a == b)
    }
}
