import Testing
@testable import Hnefatafl

@Suite("Edge Distance Calc Tests")
struct EdgeDistanceCalcTests {

    @Test("corner has distance zero")
    func cornerDistanceZero() {
        #expect(EdgeDistanceCalc.minEdgeDistance(row: 0, col: 0) == 0)
    }

    @Test("center has distance five")
    func centerDistanceFive() {
        #expect(EdgeDistanceCalc.minEdgeDistance(row: 5, col: 5) == 5)
    }

    @Test("average edge distance for start position")
    func averageStart() {
        let position = Position.copenhagenStart()
        let avg = EdgeDistanceCalc.averageEdgeDistance(position: position, player: .attacker)
        #expect(avg > 0)
    }

    @Test("empty board average is zero")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(EdgeDistanceCalc.averageEdgeDistance(position: position, player: .attacker) == 0)
    }

    @Test("edge piece has distance zero")
    func edgePieceZero() {
        #expect(EdgeDistanceCalc.minEdgeDistance(row: 0, col: 5) == 0)
    }
}
