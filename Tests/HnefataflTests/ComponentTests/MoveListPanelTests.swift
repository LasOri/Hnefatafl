import Testing
@testable import Hnefatafl

@Suite("MoveListPanel Tests")
struct MoveListPanelTests {
    @Test("Compact preset is not expanded")
    func compactNotExpanded() {
        #expect(!MoveListPanel.compact.isExpanded)
    }

    @Test("Expanded preset is expanded")
    func expandedIsExpanded() {
        #expect(MoveListPanel.expanded.isExpanded)
    }

    @Test("Compact has small max visible")
    func compactMaxVisible() {
        #expect(MoveListPanel.compact.maxVisible == 5)
    }

    @Test("Expanded has large max visible")
    func expandedMaxVisible() {
        #expect(MoveListPanel.expanded.maxVisible == 50)
    }

    @Test("Both presets show numbers")
    func bothShowNumbers() {
        #expect(MoveListPanel.compact.showNumbers)
        #expect(MoveListPanel.expanded.showNumbers)
    }

    @Test("Panels are equatable")
    func equatable() {
        let a = MoveListPanel.compact
        let b = MoveListPanel.compact
        #expect(a == b)
    }

    @Test("Compact and expanded are not equal")
    func presetsNotEqual() {
        #expect(MoveListPanel.compact != MoveListPanel.expanded)
    }
}
