import Testing
@testable import Hnefatafl

@Suite("Scroll Position Tests")
struct ScrollPositionTests {

    @Test("canScrollUp false at top")
    func cannotScrollUpAtTop() {
        let sp = ScrollPosition(offset: 0, visibleCount: 5, totalCount: 20)
        #expect(!sp.canScrollUp)
    }

    @Test("canScrollUp true when offset positive")
    func canScrollUpPositiveOffset() {
        let sp = ScrollPosition(offset: 3, visibleCount: 5, totalCount: 20)
        #expect(sp.canScrollUp)
    }

    @Test("canScrollDown true when more items below")
    func canScrollDownMoreItems() {
        let sp = ScrollPosition(offset: 0, visibleCount: 5, totalCount: 20)
        #expect(sp.canScrollDown)
    }

    @Test("canScrollDown false at bottom")
    func cannotScrollDownAtBottom() {
        let sp = ScrollPosition(offset: 15, visibleCount: 5, totalCount: 20)
        #expect(!sp.canScrollDown)
    }

    @Test("scrollPercentage at start is zero")
    func percentageAtStartZero() {
        let sp = ScrollPosition(offset: 0, visibleCount: 5, totalCount: 20)
        #expect(sp.scrollPercentage == 0)
    }

    @Test("scrollPercentage with empty total is zero")
    func percentageEmptyTotalZero() {
        let sp = ScrollPosition(offset: 0, visibleCount: 0, totalCount: 0)
        #expect(sp.scrollPercentage == 0)
    }

    @Test("scroll positions are equatable")
    func equatable() {
        let a = ScrollPosition(offset: 5, visibleCount: 10, totalCount: 50)
        let b = ScrollPosition(offset: 5, visibleCount: 10, totalCount: 50)
        let c = ScrollPosition(offset: 6, visibleCount: 10, totalCount: 50)
        #expect(a == b)
        #expect(a != c)
    }
}
