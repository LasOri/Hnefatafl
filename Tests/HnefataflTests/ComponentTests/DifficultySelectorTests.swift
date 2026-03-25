import Testing
@testable import Hnefatafl

@Suite("Difficulty Selector Tests")
struct DifficultySelectorTests {

    @Test("beginner has search depth 1")
    func beginnerDepth() {
        #expect(DifficultyLevel.beginner.searchDepth == 1)
    }

    @Test("expert has search depth 4")
    func expertDepth() {
        #expect(DifficultyLevel.expert.searchDepth == 4)
    }

    @Test("next after beginner is intermediate")
    func nextAfterBeginner() {
        let next = DifficultySelector.next(after: .beginner)
        #expect(next == .intermediate)
    }

    @Test("next after expert wraps to beginner")
    func nextAfterExpertWraps() {
        let next = DifficultySelector.next(after: .expert)
        #expect(next == .beginner)
    }

    @Test("all cases has four levels")
    func allCasesCount() {
        #expect(DifficultyLevel.allCases.count == 4)
    }
}
