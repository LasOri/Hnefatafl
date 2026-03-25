import Testing
@testable import Hnefatafl

@Suite("CoverageMap Tests")
struct CoverageMapTests {

    @Test("empty board has zero coverage")
    func emptyBoardZeroCoverage() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let map = CoverageMapBuilder.build(position: position, player: .attacker)
        #expect(map.maxCoverage == 0)
    }

    @Test("start position attacker coverage is nonzero")
    func startPositionAttackerCoverage() {
        let position = Position.copenhagenStart()
        let map = CoverageMapBuilder.build(position: position, player: .attacker)
        #expect(map.maxCoverage > 0)
    }

    @Test("value at specific square")
    func valueAtSquare() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let map = CoverageMapBuilder.build(position: position, player: .attacker)
        #expect(map.value(row: 0, col: 0) == 0)
    }

    @Test("single piece covers reachable squares")
    func singlePieceCoverage() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let map = CoverageMapBuilder.build(position: position, player: .attacker)
        #expect(map.maxCoverage >= 1)
    }

    @Test("coverage map equality")
    func coverageEquality() {
        let cov1 = CoverageMap(coverage: Array(repeating: 0, count: 121))
        let cov2 = CoverageMap(coverage: Array(repeating: 0, count: 121))
        #expect(cov1 == cov2)
    }
}
