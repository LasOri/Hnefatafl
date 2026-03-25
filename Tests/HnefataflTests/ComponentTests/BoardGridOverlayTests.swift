import Testing
@testable import Hnefatafl

@Suite("BoardGridOverlay Tests")
struct BoardGridOverlayTests {
    @Test("Creates grid line")
    func createGridLine() {
        let line = GridLine(start: (0, 0), end: (0, 10), color: "black")
        #expect(line.start == (0, 0))
        #expect(line.end == (0, 10))
        #expect(line.color == "black")
    }

    @Test("Generates lines for 11x11 board")
    func linesFor11x11() {
        let overlay = BoardGridOverlay()
        let lines = overlay.lines(for: 11)
        #expect(lines.count == 24)
    }

    @Test("Generates lines for 9x9 board")
    func linesFor9x9() {
        let overlay = BoardGridOverlay()
        let lines = overlay.lines(for: 9)
        #expect(lines.count == 20)
    }

    @Test("Generates CSS lines")
    func cssLines() {
        let overlay = BoardGridOverlay()
        let css = overlay.cssLines(for: 11)
        #expect(css.count > 0)
    }

    @Test("Grid line equality")
    func gridLineEquality() {
        let line1 = GridLine(start: (0, 0), end: (10, 0), color: "gray")
        let line2 = GridLine(start: (0, 0), end: (10, 0), color: "gray")
        #expect(line1 == line2)
    }

    @Test("CSS line contains color")
    func cssLineContainsColor() {
        let overlay = BoardGridOverlay()
        let css = overlay.cssLines(for: 5)
        #expect(css[0].contains(overlay.defaultColor))
    }
}
