import Testing
@testable import Hnefatafl

@Suite("Move Arrow Tests")
struct MoveArrowTests {

    @Test("creates from move")
    func createsFromMove() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let arrow = MoveArrow.from(move: move, color: "red")
        #expect(arrow.fromRow == 0)
        #expect(arrow.fromCol == 0)
        #expect(arrow.toRow == 0)
        #expect(arrow.toCol == 5)
        #expect(arrow.color == "red")
    }

    @Test("horizontal move detected")
    func horizontalMove() {
        let arrow = MoveArrow(fromRow: 3, fromCol: 0, toRow: 3, toCol: 5, color: "blue")
        #expect(arrow.isHorizontal)
        #expect(!arrow.isVertical)
    }

    @Test("vertical move detected")
    func verticalMove() {
        let arrow = MoveArrow(fromRow: 0, fromCol: 3, toRow: 5, toCol: 3, color: "green")
        #expect(arrow.isVertical)
        #expect(!arrow.isHorizontal)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = MoveArrow(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, color: "red")
        let b = MoveArrow(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, color: "red")
        #expect(a == b)
    }

    @Test("different colors not equal")
    func differentColorsNotEqual() {
        let a = MoveArrow(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, color: "red")
        let b = MoveArrow(fromRow: 1, fromCol: 2, toRow: 3, toCol: 4, color: "blue")
        #expect(a != b)
    }

    @Test("same row and col is both horizontal and vertical")
    func stationaryIsBoth() {
        let arrow = MoveArrow(fromRow: 5, fromCol: 5, toRow: 5, toCol: 5, color: "gray")
        #expect(arrow.isHorizontal)
        #expect(arrow.isVertical)
    }
}
