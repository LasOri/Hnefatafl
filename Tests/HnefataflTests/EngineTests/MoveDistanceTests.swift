import Testing
@testable import Hnefatafl

@Suite("MoveDistance Tests")
struct MoveDistanceTests {

    @Test("manhattan distance for horizontal move")
    func horizontalMove() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        #expect(MoveDistance.manhattan(move) == 5)
    }

    @Test("manhattan distance for vertical move")
    func verticalMove() {
        let move = Move(fromRow: 2, fromCol: 3, toRow: 8, toCol: 3)
        #expect(MoveDistance.manhattan(move) == 6)
    }

    @Test("average move distance for empty list")
    func averageEmpty() {
        #expect(MoveDistance.averageMoveDistance(moves: []) == 0)
    }

    @Test("average move distance for multiple moves")
    func averageMultiple() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 4),
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 6)
        ]
        #expect(MoveDistance.averageMoveDistance(moves: moves) == 5.0)
    }

    @Test("max distance from moves")
    func maxDistanceMoves() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 2),
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 10)
        ]
        #expect(MoveDistance.maxDistance(moves: moves) == 10)
    }
}
