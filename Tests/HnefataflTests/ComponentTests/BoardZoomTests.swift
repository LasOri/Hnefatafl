import Testing
@testable import Hnefatafl

@Suite("Board Zoom Tests")
struct BoardZoomTests {

    @Test("default zoom is 1.0")
    func defaultZoom() {
        let zoom = BoardZoom()
        #expect(zoom.scale == 1.0)
    }

    @Test("zoom in increases scale")
    func zoomIn() {
        let zoom = BoardZoom().zoomIn()
        #expect(zoom.scale > 1.0)
    }

    @Test("zoom out decreases scale")
    func zoomOut() {
        let zoom = BoardZoom().zoomOut()
        #expect(zoom.scale < 1.0)
    }

    @Test("zoom has minimum")
    func zoomMin() {
        var zoom = BoardZoom()
        for _ in 0..<20 { zoom = zoom.zoomOut() }
        #expect(zoom.scale >= BoardZoom.minScale)
    }

    @Test("zoom has maximum")
    func zoomMax() {
        var zoom = BoardZoom()
        for _ in 0..<20 { zoom = zoom.zoomIn() }
        #expect(zoom.scale <= BoardZoom.maxScale)
    }

    @Test("reset returns to 1.0")
    func reset() {
        let zoom = BoardZoom().zoomIn().zoomIn().reset()
        #expect(zoom.scale == 1.0)
    }

    @Test("pan offset defaults to zero")
    func defaultPan() {
        let zoom = BoardZoom()
        #expect(zoom.offsetX == 0)
        #expect(zoom.offsetY == 0)
    }

    @Test("pan moves offset")
    func panMoves() {
        let zoom = BoardZoom().pan(dx: 10, dy: 20)
        #expect(zoom.offsetX == 10)
        #expect(zoom.offsetY == 20)
    }

    @Test("css transform includes scale and translate")
    func cssTransform() {
        let zoom = BoardZoom().zoomIn().pan(dx: 5, dy: 10)
        let css = zoom.cssTransform
        #expect(css.contains("scale"))
        #expect(css.contains("translate"))
    }

    @Test("BoardZoom is Equatable")
    func equatable() {
        let a = BoardZoom()
        let b = BoardZoom()
        #expect(a == b)
    }
}
