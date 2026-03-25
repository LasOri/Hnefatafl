import Testing
@testable import Hnefatafl

@Suite("Node Counter Tests")
struct NodeCounterTests {

    @Test("initial values are zero")
    func initialZero() {
        let counter = NodeCounter()
        #expect(counter.leafNodes == 0)
        #expect(counter.interiorNodes == 0)
        #expect(counter.totalNodes == 0)
    }

    @Test("record leaf increments leaf count")
    func recordLeaf() {
        var counter = NodeCounter()
        counter.recordLeaf()
        counter.recordLeaf()
        #expect(counter.leafNodes == 2)
    }

    @Test("record interior increments interior count")
    func recordInterior() {
        var counter = NodeCounter()
        counter.recordInterior()
        #expect(counter.interiorNodes == 1)
    }

    @Test("total sums leaf and interior")
    func totalSumsBoth() {
        var counter = NodeCounter()
        counter.recordLeaf()
        counter.recordLeaf()
        counter.recordInterior()
        #expect(counter.totalNodes == 3)
    }

    @Test("branching factor calculated correctly")
    func branchingFactor() {
        var counter = NodeCounter()
        counter.recordInterior()
        counter.recordLeaf()
        counter.recordLeaf()
        counter.recordLeaf()
        #expect(counter.branchingFactor == 4.0)
    }

    @Test("reset clears all counts")
    func resetClears() {
        var counter = NodeCounter()
        counter.recordLeaf()
        counter.recordInterior()
        counter.reset()
        #expect(counter.totalNodes == 0)
        #expect(counter.branchingFactor == 0)
    }
}
