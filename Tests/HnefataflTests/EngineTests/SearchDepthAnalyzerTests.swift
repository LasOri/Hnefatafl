import Testing
@testable import Hnefatafl

@Suite("SearchDepthAnalyzer Tests")
struct SearchDepthAnalyzerTests {

    @Test("empty analyzer has no records")
    func empty() {
        let analyzer = SearchDepthAnalyzer()
        #expect(analyzer.recordCount == 0)
    }

    @Test("record depth stores entry")
    func recordDepth() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 1000)
        #expect(analyzer.recordCount == 1)
    }

    @Test("average actual depth")
    func averageDepth() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 500)
        analyzer.record(requestedDepth: 3, actualDepth: 2, nodesSearched: 200)
        #expect(analyzer.averageActualDepth == 2.5)
    }

    @Test("average nodes searched")
    func averageNodes() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 1000)
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 2000)
        #expect(analyzer.averageNodesSearched == 1500.0)
    }

    @Test("max depth reached")
    func maxDepth() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 2, nodesSearched: 100)
        analyzer.record(requestedDepth: 3, actualDepth: 4, nodesSearched: 500)
        #expect(analyzer.maxDepthReached == 4)
    }

    @Test("depth efficiency ratio")
    func efficiency() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 4, actualDepth: 3, nodesSearched: 100)
        #expect(analyzer.depthEfficiency == 0.75)
    }

    @Test("clear resets all records")
    func clear() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 100)
        analyzer.clear()
        #expect(analyzer.recordCount == 0)
    }

    @Test("SearchDepthAnalyzer is Equatable")
    func equatable() {
        let a = SearchDepthAnalyzer()
        let b = SearchDepthAnalyzer()
        #expect(a == b)
    }

    @Test("totalNodesSearched sums all")
    func totalNodes() {
        var analyzer = SearchDepthAnalyzer()
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 100)
        analyzer.record(requestedDepth: 3, actualDepth: 3, nodesSearched: 200)
        #expect(analyzer.totalNodesSearched == 300)
    }
}
