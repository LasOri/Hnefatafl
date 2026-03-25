import Testing
@testable import Hnefatafl

@Suite("Game Stats Dashboard Tests")
struct GameStatsDashboardTests {

    @Test("dashboard has sections")
    func hasSections() {
        let dashboard = GameStatsDashboard.build(state: GameState())
        #expect(!dashboard.sections.isEmpty)
    }

    @Test("material section present")
    func materialSection() {
        let dashboard = GameStatsDashboard.build(state: GameState())
        #expect(dashboard.sections.contains { $0.title == "Material" })
    }

    @Test("turn section present")
    func turnSection() {
        let dashboard = GameStatsDashboard.build(state: GameState())
        #expect(dashboard.sections.contains { $0.title == "Turn" })
    }

    @Test("section has entries")
    func sectionHasEntries() {
        let dashboard = GameStatsDashboard.build(state: GameState())
        for section in dashboard.sections {
            #expect(!section.entries.isEmpty)
        }
    }

    @Test("DashboardEntry has label and value")
    func entryProperties() {
        let entry = DashboardEntry(label: "Test", value: "42")
        #expect(entry.label == "Test")
        #expect(entry.value == "42")
    }

    @Test("DashboardSection is Equatable")
    func sectionEquatable() {
        let a = DashboardSection(title: "X", entries: [])
        let b = DashboardSection(title: "X", entries: [])
        #expect(a == b)
    }
}
