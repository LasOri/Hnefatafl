import Testing
@testable import Hnefatafl

@Suite("Cell Size Tests")
struct CellSizeTests {

    @Test("isSquare true when width equals height")
    func isSquareTrue() {
        let size = CellSize(width: 40, height: 40)
        #expect(size.isSquare == true)
    }

    @Test("isSquare false when dimensions differ")
    func isSquareFalse() {
        let size = CellSize(width: 40, height: 30)
        #expect(size.isSquare == false)
    }

    @Test("responsive produces square cells")
    func responsiveSquare() {
        let size = CellSize.responsive(containerWidth: 440)
        #expect(size.isSquare == true)
    }

    @Test("responsive divides by board size")
    func responsiveDivision() {
        let size = CellSize.responsive(containerWidth: 440)
        #expect(size.width == 440 / 11)
    }

    @Test("equatable conformance")
    func equatable() {
        let a = CellSize(width: 10, height: 10)
        let b = CellSize(width: 10, height: 10)
        #expect(a == b)
    }

    @Test("different sizes are not equal")
    func notEqual() {
        let a = CellSize(width: 10, height: 10)
        let b = CellSize(width: 20, height: 20)
        #expect(a != b)
    }
}
