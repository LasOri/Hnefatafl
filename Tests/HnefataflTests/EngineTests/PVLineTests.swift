import Testing
@testable import Hnefatafl

@Suite("PV Line Tests")
struct PVLineTests {

    @Test("empty PV line")
    func emptyLine() {
        let pv = PVLine()
        #expect(pv.moves.isEmpty)
    }

    @Test("prepend adds move to front")
    func prepend() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let pv = PVLine().prepend(move)
        #expect(pv.moves.first == move)
    }

    @Test("best move is first in line")
    func bestMove() {
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        let pv = PVLine().prepend(m2).prepend(m1)
        #expect(pv.bestMove == m1)
    }

    @Test("merge combines child PV")
    func merge() {
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        let child = PVLine().prepend(m2)
        let pv = child.prepend(m1)
        #expect(pv.moves.count == 2)
    }

    @Test("length matches move count")
    func length() {
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let pv = PVLine().prepend(m1)
        #expect(pv.length == 1)
    }

    @Test("empty PV has nil best move")
    func emptyBestMove() {
        let pv = PVLine()
        #expect(pv.bestMove == nil)
    }

    @Test("PVLine is Equatable")
    func equatable() {
        let a = PVLine()
        let b = PVLine()
        #expect(a == b)
    }

    @Test("truncate limits length")
    func truncate() {
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        let m3 = Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 7)
        let pv = PVLine().prepend(m3).prepend(m2).prepend(m1)
        let truncated = pv.truncated(to: 2)
        #expect(truncated.length == 2)
    }
}
