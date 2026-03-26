import Testing
@testable import Hnefatafl

@Suite("MovePath Tests")
struct MovePathTests {

    @Test("horizontal move path")
    func horizontal() {
        let move = Move(fromRow: 5, fromCol: 2, toRow: 5, toCol: 6)
        let path = MovePath.squares(for: move)
        #expect(path.count == 5)
        #expect(path[0] == (5, 2))
        #expect(path[4] == (5, 6))
    }

    @Test("vertical move path")
    func vertical() {
        let move = Move(fromRow: 1, fromCol: 3, toRow: 5, toCol: 3)
        let path = MovePath.squares(for: move)
        #expect(path.count == 5)
        #expect(path[0] == (1, 3))
        #expect(path[4] == (5, 3))
    }

    @Test("single square move")
    func singleSquare() {
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 4)
        let path = MovePath.squares(for: move)
        #expect(path.count == 2)
    }

    @Test("path length matches distance")
    func pathLength() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10)
        let path = MovePath.squares(for: move)
        #expect(path.count == 11)
    }

    @Test("same-square move returns single entry")
    func sameSquare() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 5)
        let path = MovePath.squares(for: move)
        #expect(path.count == 1)
    }

    @Test("reverse move has reversed path")
    func reversePath() {
        let move = Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 5)
        let path = MovePath.squares(for: move)
        #expect(path.first! == (3, 0))
        #expect(path.last! == (3, 5))
    }

    @Test("intermediate squares included")
    func intermediateSquares() {
        let move = Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 5)
        let path = MovePath.squares(for: move)
        #expect(path[1] == (2, 3))
        #expect(path[2] == (2, 4))
    }
}
