import Testing
@testable import Hnefatafl

@Suite("Game Tab Config Tests")
struct GameTabConfigTests {

    @Test("all tabs are available in CaseIterable")
    func allTabsCaseIterable() {
        #expect(GameTab.allCases.count == 4)
        #expect(GameTab.allCases.contains(.board))
        #expect(GameTab.allCases.contains(.analysis))
        #expect(GameTab.allCases.contains(.history))
        #expect(GameTab.allCases.contains(.settings))
    }

    @Test("analysis enabled when in enabled tabs")
    func analysisEnabled() {
        let config = GameTabConfig(activeTab: .board, enabledTabs: [.board, .analysis])
        #expect(config.isAnalysisEnabled)
    }

    @Test("analysis disabled when not in enabled tabs")
    func analysisDisabled() {
        let config = GameTabConfig(activeTab: .board, enabledTabs: [.board, .history])
        #expect(!config.isAnalysisEnabled)
    }

    @Test("configs with same values are equal")
    func equatable() {
        let a = GameTabConfig(activeTab: .board, enabledTabs: [.board, .settings])
        let b = GameTabConfig(activeTab: .board, enabledTabs: [.board, .settings])
        #expect(a == b)
    }

    @Test("configs with different active tabs are not equal")
    func differentActiveTabs() {
        let a = GameTabConfig(activeTab: .board, enabledTabs: [.board])
        let b = GameTabConfig(activeTab: .history, enabledTabs: [.board])
        #expect(a != b)
    }

    @Test("tabs have raw string values")
    func rawValues() {
        #expect(GameTab.board.rawValue == "board")
        #expect(GameTab.analysis.rawValue == "analysis")
        #expect(GameTab.history.rawValue == "history")
        #expect(GameTab.settings.rawValue == "settings")
    }

    @Test("empty enabled tabs disables analysis")
    func emptyDisablesAnalysis() {
        let config = GameTabConfig(activeTab: .board, enabledTabs: [])
        #expect(!config.isAnalysisEnabled)
    }
}
