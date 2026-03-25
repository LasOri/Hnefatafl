import Testing
@testable import Hnefatafl

@Suite("Board Grid Renderer Tests")
struct BoardGridRendererTests {

    @Test("total size includes border on both sides")
    func totalSizeWithBorder() {
        let renderer = BoardGridRenderer(cellSize: 40, borderWidth: 2, showCoordinates: false)
        let expected = 40 * Position.boardSize + 2 * 2
        #expect(renderer.totalSize == expected)
    }

    @Test("total size with zero border")
    func totalSizeZeroBorder() {
        let renderer = BoardGridRenderer(cellSize: 50, borderWidth: 0, showCoordinates: true)
        #expect(renderer.totalSize == 50 * Position.boardSize)
    }

    @Test("equatable same values")
    func equatableSame() {
        let a = BoardGridRenderer(cellSize: 30, borderWidth: 1, showCoordinates: true)
        let b = BoardGridRenderer(cellSize: 30, borderWidth: 1, showCoordinates: true)
        #expect(a == b)
    }

    @Test("equatable different values")
    func equatableDifferent() {
        let a = BoardGridRenderer(cellSize: 30, borderWidth: 1, showCoordinates: true)
        let b = BoardGridRenderer(cellSize: 40, borderWidth: 1, showCoordinates: true)
        #expect(a != b)
    }

    @Test("showCoordinates affects equality")
    func showCoordinatesAffectsEquality() {
        let a = BoardGridRenderer(cellSize: 30, borderWidth: 1, showCoordinates: true)
        let b = BoardGridRenderer(cellSize: 30, borderWidth: 1, showCoordinates: false)
        #expect(a != b)
    }

    @Test("cell size stored correctly")
    func cellSizeStored() {
        let renderer = BoardGridRenderer(cellSize: 64, borderWidth: 3, showCoordinates: false)
        #expect(renderer.cellSize == 64)
        #expect(renderer.borderWidth == 3)
    }
}
