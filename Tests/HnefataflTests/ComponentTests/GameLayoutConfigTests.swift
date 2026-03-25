import Testing
@testable import Hnefatafl

@Suite("Game Layout Config Tests")
struct GameLayoutConfigTests {

    @Test("standard preset values")
    func standardPreset() {
        let config = GameLayoutConfig.standard
        #expect(config.boardSize == 440)
        #expect(config.sidebarWidth == 200)
        #expect(config.headerHeight == 60)
        #expect(config.footerHeight == 40)
    }

    @Test("compact preset values")
    func compactPreset() {
        let config = GameLayoutConfig.compact
        #expect(config.boardSize == 320)
        #expect(config.sidebarWidth == 150)
        #expect(config.headerHeight == 40)
        #expect(config.footerHeight == 30)
    }

    @Test("total width is board plus sidebar")
    func totalWidthComputed() {
        let config = GameLayoutConfig.standard
        #expect(config.totalWidth == 440 + 200)
    }

    @Test("total height is board plus header plus footer")
    func totalHeightComputed() {
        let config = GameLayoutConfig.standard
        #expect(config.totalHeight == 440 + 60 + 40)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = GameLayoutConfig.standard
        let b = GameLayoutConfig(boardSize: 440, sidebarWidth: 200, headerHeight: 60, footerHeight: 40)
        #expect(a == b)
    }

    @Test("compact is smaller than standard")
    func compactSmallerThanStandard() {
        #expect(GameLayoutConfig.compact.totalWidth < GameLayoutConfig.standard.totalWidth)
        #expect(GameLayoutConfig.compact.totalHeight < GameLayoutConfig.standard.totalHeight)
    }

    @Test("custom config values")
    func customConfig() {
        let config = GameLayoutConfig(boardSize: 500, sidebarWidth: 100, headerHeight: 50, footerHeight: 50)
        #expect(config.totalWidth == 600)
        #expect(config.totalHeight == 600)
    }
}
