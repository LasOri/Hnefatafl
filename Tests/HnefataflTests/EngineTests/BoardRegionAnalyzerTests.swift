import Testing
@testable import Hnefatafl

@Suite("BoardRegionAnalyzer Tests")
struct BoardRegionAnalyzerTests {

    @Test("starting position has balanced regions")
    func startBalanced() {
        let pos = Position.copenhagenStart()
        let analysis = BoardRegionAnalyzer.analyze(position: pos)
        #expect(analysis.regions.count == 4)
    }

    @Test("region has attacker and defender counts")
    func regionCounts() {
        let pos = Position.copenhagenStart()
        let analysis = BoardRegionAnalyzer.analyze(position: pos)
        let total = analysis.regions.reduce(0) { $0 + $1.attackerCount + $1.defenderCount }
        #expect(total > 0)
    }

    @Test("empty board has zero counts in all regions")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let analysis = BoardRegionAnalyzer.analyze(position: pos)
        let total = analysis.regions.reduce(0) { $0 + $1.attackerCount + $1.defenderCount }
        #expect(total == 0)
    }

    @Test("RegionAnalysis is Equatable")
    func equatable() {
        let a = RegionInfo(name: "NW", attackerCount: 0, defenderCount: 0)
        let b = RegionInfo(name: "NW", attackerCount: 0, defenderCount: 0)
        #expect(a == b)
    }

    @Test("regions named NW, NE, SW, SE")
    func regionNames() {
        let pos = Position.copenhagenStart()
        let analysis = BoardRegionAnalyzer.analyze(position: pos)
        let names = analysis.regions.map(\.name).sorted()
        #expect(names == ["NE", "NW", "SE", "SW"])
    }

    @Test("mostContested returns region with most pieces")
    func mostContested() {
        let pos = Position.copenhagenStart()
        let analysis = BoardRegionAnalyzer.analyze(position: pos)
        #expect(analysis.mostContested != nil)
    }

    @Test("BoardAnalysisResult is Equatable")
    func resultEquatable() {
        let a = BoardAnalysisResult(regions: [])
        let b = BoardAnalysisResult(regions: [])
        #expect(a == b)
    }
}
