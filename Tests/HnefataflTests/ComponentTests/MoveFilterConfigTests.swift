import Testing
@testable import Hnefatafl

@Suite("MoveFilterConfig Tests")
struct MoveFilterConfigTests {

    @Test("default filter type is all")
    func defaultFilterTypeAll() {
        #expect(MoveFilterConfig.defaultFilter.filterType == .all)
    }

    @Test("default does not sort by quality")
    func defaultNoSort() {
        #expect(!MoveFilterConfig.defaultFilter.sortByQuality)
    }

    @Test("MoveFilterType has four cases")
    func fourFilterTypes() {
        #expect(MoveFilterType.allCases.count == 4)
    }

    @Test("filter types have correct raw values")
    func rawValues() {
        #expect(MoveFilterType.all.rawValue == "all")
        #expect(MoveFilterType.captures.rawValue == "captures")
        #expect(MoveFilterType.threats.rawValue == "threats")
        #expect(MoveFilterType.retreats.rawValue == "retreats")
    }

    @Test("equality works for configs")
    func equalityWorks() {
        let a = MoveFilterConfig(filterType: .captures, sortByQuality: true)
        let b = MoveFilterConfig(filterType: .captures, sortByQuality: true)
        #expect(a == b)
    }

    @Test("different filter types are not equal")
    func differentNotEqual() {
        let a = MoveFilterConfig(filterType: .all, sortByQuality: false)
        let b = MoveFilterConfig(filterType: .threats, sortByQuality: false)
        #expect(a != b)
    }
}
