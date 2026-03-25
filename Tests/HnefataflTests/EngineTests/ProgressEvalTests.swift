import Testing
@testable import Hnefatafl

@Suite("Progress Eval Tests")
struct ProgressEvalTests {

    @Test("starting position has zero progress")
    func startZeroProgress() {
        let position = Position.copenhagenStart()
        let progress = ProgressEval.gameProgress(position: position)
        #expect(progress >= 0.0)
        #expect(progress < 0.1)
    }

    @Test("empty board has maximum progress")
    func emptyBoardMaxProgress() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let progress = ProgressEval.gameProgress(position: position)
        #expect(progress == 1.0)
    }

    @Test("move progress at zero is zero")
    func moveProgressZero() {
        let progress = ProgressEval.moveProgress(moveCount: 0)
        #expect(progress == 0.0)
    }

    @Test("move progress at expected length is 1.0")
    func moveProgressFull() {
        let progress = ProgressEval.moveProgress(moveCount: 80)
        #expect(progress == 1.0)
    }

    @Test("move progress clamps to 1.0")
    func moveProgressClamped() {
        let progress = ProgressEval.moveProgress(moveCount: 200)
        #expect(progress == 1.0)
    }
}
