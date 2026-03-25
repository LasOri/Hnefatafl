enum GameTab: String, CaseIterable, Equatable {
    case board
    case analysis
    case history
    case settings
}

struct GameTabConfig: Equatable {
    var activeTab: GameTab
    var enabledTabs: [GameTab]

    var isAnalysisEnabled: Bool {
        enabledTabs.contains(.analysis)
    }
}
