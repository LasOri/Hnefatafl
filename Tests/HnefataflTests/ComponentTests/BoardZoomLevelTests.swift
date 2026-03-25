import Testing
@testable import Hnefatafl

@Suite("Board Zoom Level Tests")
struct BoardZoomLevelTests {

    @Test("three zoom levels available")
    func threeLevels() {
        #expect(BoardZoomControl.levels.count == 3)
    }

    @Test("next cycles through levels")
    func nextCycles() {
        let first = BoardZoomControl.next(after: .normal)
        #expect(first == .large)
        let second = BoardZoomControl.next(after: .large)
        #expect(second == .extraLarge)
        let wrap = BoardZoomControl.next(after: .extraLarge)
        #expect(wrap == .normal)
    }

    @Test("css transform format")
    func cssTransformFormat() {
        let css = BoardZoomControl.cssTransform(for: .normal)
        #expect(css.contains("transform"))
        #expect(css.contains("scale"))
    }

    @Test("normal is 1.0 scale")
    func normalIsOne() {
        #expect(ZoomLevel.normal.scale == 1.0)
    }

    @Test("labels match expected strings")
    func labelsMatch() {
        #expect(ZoomLevel.normal.label == "100%")
        #expect(ZoomLevel.large.label == "125%")
        #expect(ZoomLevel.extraLarge.label == "150%")
    }
}
