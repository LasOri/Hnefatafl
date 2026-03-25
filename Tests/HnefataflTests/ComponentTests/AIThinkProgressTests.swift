import Testing
@testable import Hnefatafl

@Suite("AIThinkProgress Tests")
struct AIThinkProgressTests {
    @Test("Creates progress with values")
    func createProgress() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 1, toCol: 0)
        let progress = ThinkProgress(currentDepth: 3, nodesSearched: 1500, elapsed: 2.5, bestMoveFound: move)
        #expect(progress.currentDepth == 3)
        #expect(progress.nodesSearched == 1500)
        #expect(progress.elapsed == 2.5)
        #expect(progress.bestMoveFound == move)
    }

    @Test("Calculates percentage of max depth")
    func percentage() {
        let progress = ThinkProgress(currentDepth: 3, nodesSearched: 1000, elapsed: 1.0, bestMoveFound: nil)
        #expect(progress.percentage(of: 5) == 60.0)
    }

    @Test("Returns true when thinking")
    func isThinking() {
        let progress = ThinkProgress(currentDepth: 2, nodesSearched: 500, elapsed: 0.5, bestMoveFound: nil)
        #expect(progress.isThinking == true)
    }

    @Test("Returns false when not thinking at depth zero")
    func notThinking() {
        let progress = ThinkProgress(currentDepth: 0, nodesSearched: 0, elapsed: 0.0, bestMoveFound: nil)
        #expect(progress.isThinking == false)
    }

    @Test("Provides description with move")
    func descriptionWithMove() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 7)
        let progress = ThinkProgress(currentDepth: 4, nodesSearched: 2000, elapsed: 3.2, bestMoveFound: move)
        let desc = progress.description
        #expect(desc.contains("Depth 4"))
        #expect(desc.contains("2000"))
    }

    @Test("Provides description without move")
    func descriptionWithoutMove() {
        let progress = ThinkProgress(currentDepth: 1, nodesSearched: 100, elapsed: 0.1, bestMoveFound: nil)
        let desc = progress.description
        #expect(desc.contains("Depth 1"))
        #expect(desc.contains("100"))
    }
}
