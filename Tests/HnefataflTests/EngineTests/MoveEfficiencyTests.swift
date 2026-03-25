import Testing
@testable import Hnefatafl

@Suite("Move Efficiency Tests")
struct MoveEfficiencyTests {

    @Test("short move has higher efficiency than long move")
    func shortVsLong() {
        let shortMove = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let longMove = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        #expect(MoveEfficiency.efficiency(move: shortMove) > MoveEfficiency.efficiency(move: longMove))
    }

    @Test("distance-1 move has efficiency 1.0")
    func distanceOneIs1() {
        let move = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 4)
        #expect(MoveEfficiency.efficiency(move: move) == 1.0)
    }

    @Test("zero distance returns zero efficiency")
    func zeroDistanceZero() {
        let move = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 5)
        #expect(MoveEfficiency.efficiency(move: move) == 0)
    }

    @Test("mostEfficientMove returns shortest move")
    func mostEfficient() {
        let moves = [
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5),
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1),
            Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 3)
        ]
        let best = MoveEfficiency.mostEfficientMove(moves: moves)
        #expect(best == Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1))
    }

    @Test("mostEfficientMove returns nil for empty array")
    func emptyArrayNil() {
        #expect(MoveEfficiency.mostEfficientMove(moves: []) == nil)
    }

    @Test("vertical move efficiency is calculated correctly")
    func verticalMove() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 4, toCol: 3)
        #expect(MoveEfficiency.efficiency(move: move) == 0.25)
    }
}
