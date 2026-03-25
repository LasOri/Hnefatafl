import Testing
@testable import Hnefatafl

@Suite("Search Budget Tests")
struct SearchBudgetTests {

    @Test("initial budget has full remaining")
    func initialBudget() {
        let budget = SearchBudget(maxNodes: 1000)
        #expect(budget.remaining == 1000)
        #expect(budget.nodesUsed == 0)
        #expect(!budget.isExhausted)
    }

    @Test("consume reduces remaining")
    func consumeReducesRemaining() {
        var budget = SearchBudget(maxNodes: 100)
        budget.consume(30)
        #expect(budget.remaining == 70)
        #expect(budget.nodesUsed == 30)
    }

    @Test("consume default is 1")
    func consumeDefaultOne() {
        var budget = SearchBudget(maxNodes: 100)
        budget.consume()
        #expect(budget.nodesUsed == 1)
    }

    @Test("exhausted when all nodes used")
    func exhaustedWhenAllUsed() {
        var budget = SearchBudget(maxNodes: 10)
        budget.consume(10)
        #expect(budget.isExhausted)
        #expect(budget.remaining == 0)
    }

    @Test("usage percent calculation")
    func usagePercent() {
        var budget = SearchBudget(maxNodes: 200)
        budget.consume(100)
        #expect(abs(budget.usagePercent - 50.0) < 0.001)
    }

    @Test("reset restores budget")
    func resetRestoresBudget() {
        var budget = SearchBudget(maxNodes: 100)
        budget.consume(50)
        budget.reset()
        #expect(budget.nodesUsed == 0)
        #expect(budget.remaining == 100)
        #expect(!budget.isExhausted)
    }
}
