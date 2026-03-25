import Testing
@testable import Hnefatafl

@Suite("WindowLayoutConfig Tests")
struct WindowLayoutConfigTests {

    @Test("defaultLayout has correct dimensions")
    func defaultLayoutDimensions() {
        let layout = WindowLayoutConfig.defaultLayout
        #expect(layout.width == 1024)
        #expect(layout.height == 768)
    }

    @Test("defaultLayout is not fullscreen")
    func defaultNotFullscreen() {
        #expect(WindowLayoutConfig.defaultLayout.isFullscreen == false)
    }

    @Test("defaultLayout scale is 1.0")
    func defaultScaleOne() {
        #expect(WindowLayoutConfig.defaultLayout.scale == 1.0)
    }

    @Test("effectiveWidth scales correctly")
    func effectiveWidthScales() {
        let layout = WindowLayoutConfig(width: 100, height: 200, isFullscreen: false, scale: 2.0)
        #expect(layout.effectiveWidth == 200)
    }

    @Test("effectiveHeight scales correctly")
    func effectiveHeightScales() {
        let layout = WindowLayoutConfig(width: 100, height: 200, isFullscreen: false, scale: 1.5)
        #expect(layout.effectiveHeight == 300)
    }

    @Test("WindowLayoutConfig conforms to Equatable")
    func equatableConformance() {
        let a = WindowLayoutConfig(width: 800, height: 600, isFullscreen: false, scale: 1.0)
        let b = WindowLayoutConfig(width: 800, height: 600, isFullscreen: false, scale: 1.0)
        #expect(a == b)
    }

    @Test("default effective dimensions match base dimensions at scale 1.0")
    func defaultEffectiveDimensions() {
        let layout = WindowLayoutConfig.defaultLayout
        #expect(layout.effectiveWidth == 1024)
        #expect(layout.effectiveHeight == 768)
    }
}
