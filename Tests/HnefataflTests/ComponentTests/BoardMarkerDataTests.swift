import Testing
@testable import Hnefatafl

@Suite("BoardMarkerData Tests")
struct BoardMarkerDataTests {

    @Test("marker stores row and col")
    func storesPosition() {
        let marker = BoardMarkerData(row: 3, col: 7, shape: .circle, color: "red")
        #expect(marker.row == 3)
        #expect(marker.col == 7)
    }

    @Test("marker stores shape")
    func storesShape() {
        let marker = BoardMarkerData(row: 0, col: 0, shape: .arrow, color: "blue")
        #expect(marker.shape == .arrow)
    }

    @Test("marker stores color")
    func storesColor() {
        let marker = BoardMarkerData(row: 5, col: 5, shape: .dot, color: "#FF0000")
        #expect(marker.color == "#FF0000")
    }

    @Test("MarkerShape has four cases")
    func fourShapes() {
        #expect(MarkerShape.allCases.count == 4)
    }

    @Test("equality works for identical markers")
    func equalityWorks() {
        let a = BoardMarkerData(row: 1, col: 2, shape: .square, color: "green")
        let b = BoardMarkerData(row: 1, col: 2, shape: .square, color: "green")
        #expect(a == b)
    }

    @Test("different shapes are not equal")
    func differentShapesNotEqual() {
        let a = BoardMarkerData(row: 1, col: 2, shape: .circle, color: "red")
        let b = BoardMarkerData(row: 1, col: 2, shape: .dot, color: "red")
        #expect(a != b)
    }

    @Test("MarkerShape raw values are lowercase strings")
    func rawValues() {
        #expect(MarkerShape.circle.rawValue == "circle")
        #expect(MarkerShape.square.rawValue == "square")
        #expect(MarkerShape.arrow.rawValue == "arrow")
        #expect(MarkerShape.dot.rawValue == "dot")
    }
}
