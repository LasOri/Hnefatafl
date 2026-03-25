import Testing
@testable import Hnefatafl

@Suite("Board Coordinate Labels Tests")
struct BoardCoordinateLabelsTests {

    @Test("returns 11 column labels")
    func elevenColumnLabels() {
        let labels = BoardCoordinateLabels.columnLabels()
        #expect(labels.count == 11)
    }

    @Test("returns 11 row labels")
    func elevenRowLabels() {
        let labels = BoardCoordinateLabels.rowLabels()
        #expect(labels.count == 11)
    }

    @Test("column labels are a through k")
    func columnLabelsAtoK() {
        let labels = BoardCoordinateLabels.columnLabels()
        #expect(labels.first?.text == "a")
        #expect(labels.last?.text == "k")
    }

    @Test("row labels are 11 down to 1")
    func rowLabels11to1() {
        let labels = BoardCoordinateLabels.rowLabels()
        #expect(labels.first?.text == "11")
        #expect(labels.last?.text == "1")
    }

    @Test("square label format is correct")
    func squareLabelFormat() {
        #expect(BoardCoordinateLabels.squareLabel(row: 0, col: 0) == "a11")
        #expect(BoardCoordinateLabels.squareLabel(row: 10, col: 10) == "k1")
        #expect(BoardCoordinateLabels.squareLabel(row: 5, col: 5) == "f6")
    }
}
