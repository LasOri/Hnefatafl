import Testing
@testable import Hnefatafl

@Suite("GameContainer Tests")
struct GameContainerTests {
    @Test("Standard preset is centered")
    func standardCentered() {
        #expect(GameContainer.standard.centered)
    }

    @Test("FullWidth preset is not centered")
    func fullWidthNotCentered() {
        #expect(!GameContainer.fullWidth.centered)
    }

    @Test("Standard has max width 800")
    func standardMaxWidth() {
        #expect(GameContainer.standard.maxWidth == 800)
    }

    @Test("FullWidth has Int.max width")
    func fullWidthMaxWidth() {
        #expect(GameContainer.fullWidth.maxWidth == Int.max)
    }

    @Test("Standard background color")
    func standardBackgroundColor() {
        #expect(GameContainer.standard.backgroundColor == "#f5f0e8")
    }

    @Test("Containers are equatable")
    func equatable() {
        let a = GameContainer.standard
        let b = GameContainer.standard
        #expect(a == b)
    }

    @Test("Standard and fullWidth are not equal")
    func presetsNotEqual() {
        #expect(GameContainer.standard != GameContainer.fullWidth)
    }
}
