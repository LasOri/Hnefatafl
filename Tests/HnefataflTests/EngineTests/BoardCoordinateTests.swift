import Testing
@testable import Hnefatafl

@Suite("BoardCoordinate Tests")
struct BoardCoordinateTests {

    @Test("create valid coordinate")
    func validCoordinate() {
        let coord = BoardCoordinate(row: 5, col: 5)
        #expect(coord.row == 5)
        #expect(coord.col == 5)
    }

    @Test("isValid for in-bounds coordinate")
    func isValid() {
        let coord = BoardCoordinate(row: 0, col: 0)
        #expect(coord.isValid)
    }

    @Test("isValid false for out-of-bounds")
    func invalidCoord() {
        let coord = BoardCoordinate(row: 11, col: 0)
        #expect(!coord.isValid)
    }

    @Test("isCorner detects corners")
    func corners() {
        #expect(BoardCoordinate(row: 0, col: 0).isCorner)
        #expect(BoardCoordinate(row: 0, col: 10).isCorner)
        #expect(BoardCoordinate(row: 10, col: 0).isCorner)
        #expect(BoardCoordinate(row: 10, col: 10).isCorner)
        #expect(!BoardCoordinate(row: 5, col: 5).isCorner)
    }

    @Test("isThrone detects center")
    func throne() {
        #expect(BoardCoordinate(row: 5, col: 5).isThrone)
        #expect(!BoardCoordinate(row: 0, col: 0).isThrone)
    }

    @Test("isEdge detects edges")
    func edges() {
        #expect(BoardCoordinate(row: 0, col: 5).isEdge)
        #expect(BoardCoordinate(row: 10, col: 3).isEdge)
        #expect(!BoardCoordinate(row: 5, col: 5).isEdge)
    }

    @Test("algebraic notation")
    func algebraic() {
        let coord = BoardCoordinate(row: 0, col: 0)
        #expect(coord.algebraic == "a11")
    }

    @Test("BoardCoordinate is Equatable")
    func equatable() {
        let a = BoardCoordinate(row: 3, col: 7)
        let b = BoardCoordinate(row: 3, col: 7)
        #expect(a == b)
    }

    @Test("manhattanDistance computes correctly")
    func manhattan() {
        let a = BoardCoordinate(row: 0, col: 0)
        let b = BoardCoordinate(row: 5, col: 5)
        #expect(a.manhattanDistance(to: b) == 10)
    }

    @Test("allCoordinates returns 121 entries")
    func allCoords() {
        #expect(BoardCoordinate.allCoordinates.count == 121)
    }
}
