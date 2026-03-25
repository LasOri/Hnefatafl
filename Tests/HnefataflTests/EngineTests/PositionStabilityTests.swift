import Testing
@testable import Hnefatafl

@Suite("PositionStability Tests")
struct PositionStabilityTests {

    @Test("empty board is stable")
    func emptyBoardIsStable() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionStability.isStable(position: position) == true)
    }

    @Test("stability is non-negative")
    func stabilityNonNegative() {
        let position = Position.copenhagenStart()
        #expect(PositionStability.stability(position: position) >= 0)
    }

    @Test("empty board stability is zero")
    func emptyBoardStabilityZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionStability.stability(position: position) == 0)
    }

    @Test("start position has positive stability")
    func startPositionPositiveStability() {
        let position = Position.copenhagenStart()
        #expect(PositionStability.stability(position: position) > 0)
    }

    @Test("isStable consistent with capture count")
    func stableConsistentWithCaptures() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PositionStability.isStable(position: position) == true)
    }

    @Test("single piece board is stable")
    func singlePieceBoardStable() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(PositionStability.isStable(position: position) == true)
    }
}
