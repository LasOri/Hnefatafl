import Testing
@testable import Hnefatafl

@Suite("GameDebugPanel Tests")
struct GameDebugPanelTests {
    @Test("Summary contains eval score")
    func summaryContainsEval() {
        let panel = GameDebugPanel(isVisible: true, evalScore: 42, nodeCount: 1000, searchDepth: 5)
        #expect(panel.summary.contains("42"))
    }

    @Test("Summary contains node count")
    func summaryContainsNodes() {
        let panel = GameDebugPanel(isVisible: true, evalScore: 0, nodeCount: 500, searchDepth: 3)
        #expect(panel.summary.contains("500"))
    }

    @Test("Summary contains search depth")
    func summaryContainsDepth() {
        let panel = GameDebugPanel(isVisible: true, evalScore: 10, nodeCount: 200, searchDepth: 7)
        #expect(panel.summary.contains("7"))
    }

    @Test("isVisible property is preserved")
    func isVisiblePreserved() {
        let hidden = GameDebugPanel(isVisible: false, evalScore: 0, nodeCount: 0, searchDepth: 0)
        #expect(hidden.isVisible == false)
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = GameDebugPanel(isVisible: true, evalScore: 10, nodeCount: 100, searchDepth: 4)
        let b = GameDebugPanel(isVisible: true, evalScore: 10, nodeCount: 100, searchDepth: 4)
        #expect(a == b)
    }

    @Test("Summary format is consistent")
    func summaryFormat() {
        let panel = GameDebugPanel(isVisible: true, evalScore: -5, nodeCount: 0, searchDepth: 1)
        #expect(panel.summary == "Eval: -5 | Nodes: 0 | Depth: 1")
    }
}
