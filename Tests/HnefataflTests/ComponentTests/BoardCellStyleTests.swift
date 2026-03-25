import Testing
@testable import Hnefatafl

@Suite("BoardCellStyle Tests")
struct BoardCellStyleTests {
    @Test("Corner cell at (0, 0)")
    func topLeftCorner() {
        let style = BoardCellStyle.style(row: 0, col: 0)
        #expect(style.isCorner == true)
        #expect(style.isThrone == false)
        #expect(style.appearance == .normal)
    }

    @Test("Corner cell at bottom right")
    func bottomRightCorner() {
        let style = BoardCellStyle.style(row: 10, col: 10)
        #expect(style.isCorner == true)
    }

    @Test("Throne cell at center")
    func throneCell() {
        let style = BoardCellStyle.style(row: 5, col: 5)
        #expect(style.isThrone == true)
        #expect(style.isCorner == false)
    }

    @Test("Regular cell is neither corner nor throne")
    func regularCell() {
        let style = BoardCellStyle.style(row: 3, col: 4)
        #expect(style.isCorner == false)
        #expect(style.isThrone == false)
        #expect(style.appearance == .normal)
    }

    @Test("CellAppearance has four cases")
    func allAppearanceCases() {
        let cases = CellAppearance.allCases
        #expect(cases.count == 4)
        #expect(cases.contains(.normal))
        #expect(cases.contains(.highlighted))
        #expect(cases.contains(.selected))
        #expect(cases.contains(.threatened))
    }

    @Test("All four corner positions are corners")
    func allCorners() {
        let corners = [(0, 0), (0, 10), (10, 0), (10, 10)]
        for (row, col) in corners {
            let style = BoardCellStyle.style(row: row, col: col)
            #expect(style.isCorner == true)
        }
    }

    @Test("Edge cell is not a corner")
    func edgeNotCorner() {
        let style = BoardCellStyle.style(row: 0, col: 5)
        #expect(style.isCorner == false)
        #expect(style.isThrone == false)
    }
}
