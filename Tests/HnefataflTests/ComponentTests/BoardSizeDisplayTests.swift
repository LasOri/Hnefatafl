import Testing
@testable import Hnefatafl

@Suite("BoardSizeDisplay Tests")
struct BoardSizeDisplayTests {

    @Test("copenhagen preset is 11x11")
    func copenhagenSize() {
        let display = BoardSizeDisplay.copenhagen
        #expect(display.rows == 11)
        #expect(display.cols == 11)
    }

    @Test("total squares computed correctly")
    func totalSquares() {
        let display = BoardSizeDisplay(rows: 11, cols: 11, label: "Test")
        #expect(display.totalSquares == 121)
    }

    @Test("copenhagen label is correct")
    func copenhagenLabel() {
        let display = BoardSizeDisplay.copenhagen
        #expect(display.label == "Copenhagen (11×11)")
    }

    @Test("custom size works")
    func customSize() {
        let display = BoardSizeDisplay(rows: 9, cols: 9, label: "Small")
        #expect(display.totalSquares == 81)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = BoardSizeDisplay(rows: 11, cols: 11, label: "A")
        let b = BoardSizeDisplay(rows: 11, cols: 11, label: "A")
        #expect(a == b)
    }

    @Test("inequal when different labels")
    func inequalLabels() {
        let a = BoardSizeDisplay(rows: 11, cols: 11, label: "A")
        let b = BoardSizeDisplay(rows: 11, cols: 11, label: "B")
        #expect(a != b)
    }
}
