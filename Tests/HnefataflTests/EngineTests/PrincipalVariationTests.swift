import Testing
@testable import Hnefatafl

@Suite("PrincipalVariation Tests")
struct PrincipalVariationTests {

    @Test("empty PV has no moves")
    func emptyPV() {
        let pv = PrincipalVariation()
        #expect(pv.isEmpty)
        #expect(pv.length == 0)
    }

    @Test("update sets best move")
    func updateSetsBestMove() {
        var pv = PrincipalVariation()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        pv.update(move: move, continuation: PrincipalVariation())
        #expect(pv.bestMove == move)
    }

    @Test("continuation appended after move")
    func continuationAppended() {
        var continuation = PrincipalVariation()
        let move2 = Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 7)
        continuation.update(move: move2, continuation: PrincipalVariation())

        var pv = PrincipalVariation()
        let move1 = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        pv.update(move: move1, continuation: continuation)
        #expect(pv.length == 2)
        #expect(pv.moves[0] == move1)
        #expect(pv.moves[1] == move2)
    }

    @Test("length tracks moves")
    func lengthTracksMoves() {
        var pv = PrincipalVariation()
        #expect(pv.length == 0)
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        pv.update(move: move, continuation: PrincipalVariation())
        #expect(pv.length == 1)
    }

    @Test("clear empties the PV")
    func clearEmpties() {
        var pv = PrincipalVariation()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        pv.update(move: move, continuation: PrincipalVariation())
        #expect(!pv.isEmpty)
        pv.clear()
        #expect(pv.isEmpty)
        #expect(pv.length == 0)
    }

    @Test("best move is first in sequence")
    func bestMoveIsFirst() {
        var pv = PrincipalVariation()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        pv.update(move: move, continuation: PrincipalVariation())
        #expect(pv.bestMove == pv.moves.first)
    }
}
