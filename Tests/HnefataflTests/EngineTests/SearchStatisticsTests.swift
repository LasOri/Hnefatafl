import Testing
@testable import Hnefatafl

@Suite("SearchStatistics Tests")
struct SearchStatisticsTests {
    @Test("Initialize with zero values")
    func initializeZero() {
        let stats = SearchStatistics()
        #expect(stats.nodesVisited == 0)
        #expect(stats.cutoffs == 0)
        #expect(stats.ttHits == 0)
        #expect(stats.ttMisses == 0)
        #expect(stats.depthReached == 0)
        #expect(stats.elapsed == 0.0)
    }

    @Test("Record node visit")
    func recordNode() {
        var stats = SearchStatistics()
        stats.recordNode()
        #expect(stats.nodesVisited == 1)
        stats.recordNode()
        #expect(stats.nodesVisited == 2)
    }

    @Test("Record cutoff")
    func recordCutoff() {
        var stats = SearchStatistics()
        stats.recordCutoff()
        #expect(stats.cutoffs == 1)
    }

    @Test("Record transposition table hit and miss")
    func recordTTAccess() {
        var stats = SearchStatistics()
        stats.recordTTHit()
        #expect(stats.ttHits == 1)
        #expect(stats.ttMisses == 0)

        stats.recordTTMiss()
        #expect(stats.ttMisses == 1)
    }

    @Test("Update depth reached")
    func updateDepth() {
        var stats = SearchStatistics()
        stats.updateDepth(3)
        #expect(stats.depthReached == 3)
        stats.updateDepth(5)
        #expect(stats.depthReached == 5)
        stats.updateDepth(2)
        #expect(stats.depthReached == 5)
    }

    @Test("Record elapsed time")
    func recordElapsed() {
        var stats = SearchStatistics()
        stats.recordElapsed(1.5)
        #expect(stats.elapsed == 1.5)
    }

    @Test("Reset statistics")
    func reset() {
        var stats = SearchStatistics()
        stats.recordNode()
        stats.recordCutoff()
        stats.recordTTHit()
        stats.updateDepth(5)
        stats.recordElapsed(2.0)

        stats.reset()
        #expect(stats.nodesVisited == 0)
        #expect(stats.cutoffs == 0)
        #expect(stats.ttHits == 0)
        #expect(stats.depthReached == 0)
        #expect(stats.elapsed == 0.0)
    }
}
