import Testing
@testable import Hnefatafl

@Suite("Game Mode Selector Tests")
struct GameModeSelectorTests {

    @Test("three modes available")
    func threeModes() {
        #expect(GameModeSelector.allModes.count == 3)
    }

    @Test("labels match raw values")
    func labelsMatch() {
        #expect(GameModeOption.humanVsHuman.label == "Human vs Human")
        #expect(GameModeOption.humanVsAI.label == "Human vs AI")
        #expect(GameModeOption.aiVsAI.label == "AI vs AI")
    }

    @Test("cycling through modes wraps around")
    func cyclingWorks() {
        let first = GameModeOption.humanVsHuman
        let second = GameModeSelector.next(after: first)
        #expect(second == .humanVsAI)
        let third = GameModeSelector.next(after: second)
        #expect(third == .aiVsAI)
        let wrapped = GameModeSelector.next(after: third)
        #expect(wrapped == .humanVsHuman)
    }

    @Test("requiresAI correct for each mode")
    func requiresAICorrect() {
        #expect(!GameModeOption.humanVsHuman.requiresAI)
        #expect(GameModeOption.humanVsAI.requiresAI)
        #expect(GameModeOption.aiVsAI.requiresAI)
    }

    @Test("isAutoPlay only for AI vs AI")
    func isAutoPlayOnlyAIvsAI() {
        #expect(!GameModeOption.humanVsHuman.isAutoPlay)
        #expect(!GameModeOption.humanVsAI.isAutoPlay)
        #expect(GameModeOption.aiVsAI.isAutoPlay)
    }
}
