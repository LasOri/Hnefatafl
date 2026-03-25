import Testing
@testable import Hnefatafl

@Suite("Board Dimensions Tests")
struct BoardDimensionsTests {

    @Test("layout with default padding")
    func defaultPadding() {
        let layout = BoardDimensions.layout(containerWidth: 440)
        #expect(layout.boardSize == 11)
        #expect(layout.squareSize > 0)
        #expect(layout.totalWidth == layout.totalHeight)
    }

    @Test("layout with custom padding")
    func customPadding() {
        let layout = BoardDimensions.layout(containerWidth: 440, padding: 20)
        let expected = (440.0 - 40.0) / 11.0
        #expect(layout.squareSize == expected)
    }

    @Test("total size equals squares plus padding")
    func totalSizeCalculation() {
        let layout = BoardDimensions.layout(containerWidth: 440, padding: 10)
        let expectedSquare = (440.0 - 20.0) / 11.0
        let expectedTotal = expectedSquare * 11.0 + 20.0
        #expect(layout.totalWidth == expectedTotal)
    }

    @Test("zero padding uses full width")
    func zeroPadding() {
        let layout = BoardDimensions.layout(containerWidth: 440, padding: 0)
        #expect(layout.squareSize == 40)
        #expect(layout.totalWidth == 440)
    }

    @Test("BoardLayoutData is equatable")
    func equatable() {
        let a = BoardDimensions.layout(containerWidth: 440)
        let b = BoardDimensions.layout(containerWidth: 440)
        #expect(a == b)
    }
}
