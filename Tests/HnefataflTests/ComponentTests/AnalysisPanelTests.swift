import Testing
@testable import Hnefatafl

@Suite("Analysis Panel Tests")
struct AnalysisPanelTests {

    @Test("data includes phase string")
    func includesPhase() {
        let position = Position.copenhagenStart()
        let data = AnalysisPanel.data(evaluation: 50, bestMove: nil, depth: 3, position: position)
        #expect(data.phase == "Opening")
    }

    @Test("data formats move as notation")
    func formatsMoveNotation() {
        let position = Position.copenhagenStart()
        let move = Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5)
        let data = AnalysisPanel.data(evaluation: 10, bestMove: move, depth: 4, position: position)
        #expect(data.bestMove != nil)
        #expect(data.bestMove == "f11-f9")
    }

    @Test("nil best move produces nil string")
    func nilMove() {
        let position = Position.copenhagenStart()
        let data = AnalysisPanel.data(evaluation: 0, bestMove: nil, depth: 1, position: position)
        #expect(data.bestMove == nil)
    }

    @Test("preserves evaluation and depth")
    func preservesValues() {
        let position = Position.copenhagenStart()
        let data = AnalysisPanel.data(evaluation: 42, bestMove: nil, depth: 7, position: position)
        #expect(data.evaluation == 42)
        #expect(data.depth == 7)
    }

    @Test("analysis data equality")
    func dataEquality() {
        let position = Position.copenhagenStart()
        let a = AnalysisPanel.data(evaluation: 10, bestMove: nil, depth: 3, position: position)
        let b = AnalysisPanel.data(evaluation: 10, bestMove: nil, depth: 3, position: position)
        #expect(a == b)
    }
}
