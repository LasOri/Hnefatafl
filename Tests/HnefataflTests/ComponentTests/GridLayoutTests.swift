import Testing
@testable import Hnefatafl

@Suite("GridLayout Tests")
struct GridLayoutTests {

    @Test("generates 121 cells")
    func cellCount() {
        let cells = GridLayout.cells(squareSize: 50.0)
        #expect(cells.count == 121)
    }

    @Test("first cell at origin with no padding")
    func firstCellOrigin() {
        let cells = GridLayout.cells(squareSize: 50.0)
        #expect(cells[0].x == 0.0)
        #expect(cells[0].y == 0.0)
        #expect(cells[0].row == 0)
        #expect(cells[0].col == 0)
    }

    @Test("padding offsets all cells")
    func paddingOffset() {
        let cells = GridLayout.cells(squareSize: 50.0, padding: 10.0)
        #expect(cells[0].x == 10.0)
        #expect(cells[0].y == 10.0)
    }

    @Test("cell size matches input")
    func cellSize() {
        let cells = GridLayout.cells(squareSize: 40.0)
        #expect(cells[0].size == 40.0)
    }

    @Test("last cell position is correct")
    func lastCellPosition() {
        let cells = GridLayout.cells(squareSize: 50.0)
        let last = cells[120]
        #expect(last.row == 10)
        #expect(last.col == 10)
        #expect(last.x == 500.0)
        #expect(last.y == 500.0)
    }
}
