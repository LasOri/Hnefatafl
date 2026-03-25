import Testing
@testable import Hnefatafl

@Suite("RookVision Tests")
struct RookVisionTests {

    @Test("can see along clear row")
    func clearRow() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(RookVision.canSee(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10, position: position))
    }

    @Test("cannot see diagonally")
    func diagonal() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(!RookVision.canSee(fromRow: 0, fromCol: 0, toRow: 3, toCol: 3, position: position))
    }

    @Test("blocked by piece in between")
    func blocked() {
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 5)
            .build()
        #expect(!RookVision.canSee(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10, position: position))
    }

    @Test("visible squares from center of empty board")
    func visibleFromCenter() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let count = RookVision.visibleSquares(row: 5, col: 5, position: position)
        #expect(count == 20)
    }

    @Test("visible squares from corner of empty board")
    func visibleFromCorner() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let count = RookVision.visibleSquares(row: 0, col: 0, position: position)
        #expect(count == 20)
    }
}
