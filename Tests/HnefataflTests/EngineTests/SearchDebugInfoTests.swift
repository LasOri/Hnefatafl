import Testing
@testable import Hnefatafl

@Suite("SearchDebugInfo Tests")
struct SearchDebugInfoTests {

    @Test("initial values are zero")
    func initialValuesZero() {
        let info = SearchDebugInfo()
        #expect(info.nodesSearched == 0)
        #expect(info.maxDepthReached == 0)
        #expect(info.cutoffs == 0)
        #expect(info.ttHits == 0)
        #expect(info.bestScore == 0)
    }

    @Test("record node increments count")
    func recordNodeIncrements() {
        var info = SearchDebugInfo()
        info.recordNode()
        #expect(info.nodesSearched == 1)
        info.recordNode()
        #expect(info.nodesSearched == 2)
    }

    @Test("record cutoff increments count")
    func recordCutoffIncrements() {
        var info = SearchDebugInfo()
        info.recordCutoff()
        #expect(info.cutoffs == 1)
        info.recordCutoff()
        #expect(info.cutoffs == 2)
    }

    @Test("update depth tracks maximum")
    func updateDepthTracksMax() {
        var info = SearchDebugInfo()
        info.updateDepth(3)
        #expect(info.maxDepthReached == 3)
        info.updateDepth(5)
        #expect(info.maxDepthReached == 5)
        info.updateDepth(2)
        #expect(info.maxDepthReached == 5)
    }

    @Test("cutoff rate calculated correctly")
    func cutoffRateCalculated() {
        var info = SearchDebugInfo()
        info.recordNode()
        info.recordNode()
        info.recordNode()
        info.recordNode()
        info.recordCutoff()
        #expect(info.cutoffRate == 25.0)
    }

    @Test("tt hits tracked")
    func ttHitsTracked() {
        var info = SearchDebugInfo()
        info.recordTTHit()
        #expect(info.ttHits == 1)
        info.recordTTHit()
        #expect(info.ttHits == 2)
    }
}
