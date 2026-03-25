import Testing
@testable import Hnefatafl

@Suite("Killer Move Tests")
struct KillerMoveTests {

    @Test("initially empty")
    func initiallyEmpty() {
        let table = KillerMoveTable()
        #expect(table.killers(at: 0).isEmpty)
    }

    @Test("stores killer move at depth")
    func storesKiller() {
        var table = KillerMoveTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.store(move: move, at: 2)
        #expect(table.killers(at: 2).contains(move))
    }

    @Test("stores up to two killers per depth")
    func twoKillers() {
        var table = KillerMoveTable()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        let m3 = Move(fromRow: 2, fromCol: 2, toRow: 2, toCol: 7)
        table.store(move: m1, at: 0)
        table.store(move: m2, at: 0)
        table.store(move: m3, at: 0)
        #expect(table.killers(at: 0).count <= 2)
    }

    @Test("does not duplicate same move")
    func noDuplicate() {
        var table = KillerMoveTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.store(move: move, at: 0)
        table.store(move: move, at: 0)
        #expect(table.killers(at: 0).count == 1)
    }

    @Test("different depths are independent")
    func independentDepths() {
        var table = KillerMoveTable()
        let m1 = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 1, toRow: 1, toCol: 6)
        table.store(move: m1, at: 0)
        table.store(move: m2, at: 1)
        #expect(table.killers(at: 0).count == 1)
        #expect(table.killers(at: 1).count == 1)
    }

    @Test("clear resets all depths")
    func clearAll() {
        var table = KillerMoveTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.store(move: move, at: 0)
        table.clear()
        #expect(table.killers(at: 0).isEmpty)
    }

    @Test("isKiller checks correctly")
    func isKiller() {
        var table = KillerMoveTable()
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        table.store(move: move, at: 3)
        #expect(table.isKiller(move: move, at: 3))
        #expect(!table.isKiller(move: move, at: 4))
    }

    @Test("max depth is reasonable")
    func maxDepth() {
        #expect(KillerMoveTable.maxDepth >= 10)
    }
}
