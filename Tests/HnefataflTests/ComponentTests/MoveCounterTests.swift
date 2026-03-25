import Testing
@testable import Hnefatafl

@Suite("Move Counter Tests")
struct MoveCounterTests {

    @Test("empty history returns zeros")
    func emptyHistory() {
        let data = MoveCounter.count(moveHistory: [])
        #expect(data.totalMoves == 0)
        #expect(data.attackerMoves == 0)
        #expect(data.defenderMoves == 0)
        #expect(data.currentMoveNumber == 1)
    }

    @Test("one move means one attacker move")
    func oneMove() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)]
        let data = MoveCounter.count(moveHistory: moves)
        #expect(data.totalMoves == 1)
        #expect(data.attackerMoves == 1)
        #expect(data.defenderMoves == 0)
        #expect(data.currentMoveNumber == 2)
    }

    @Test("two moves means one each")
    func twoMoves() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4)
        ]
        let data = MoveCounter.count(moveHistory: moves)
        #expect(data.totalMoves == 2)
        #expect(data.attackerMoves == 1)
        #expect(data.defenderMoves == 1)
    }

    @Test("odd number splits correctly")
    func oddNumber() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5),
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),
            Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 3)
        ]
        let data = MoveCounter.count(moveHistory: moves)
        #expect(data.attackerMoves == 2)
        #expect(data.defenderMoves == 1)
    }

    @Test("MoveCounterData is equatable")
    func equatable() {
        let a = MoveCounterData(totalMoves: 4, attackerMoves: 2, defenderMoves: 2, currentMoveNumber: 5)
        let b = MoveCounterData(totalMoves: 4, attackerMoves: 2, defenderMoves: 2, currentMoveNumber: 5)
        #expect(a == b)
    }
}
