import Testing
@testable import Hnefatafl

@Suite("Critical Square Tests")
struct CriticalSquareTests {

    @Test("king not on corner row or column returns empty")
    func kingAtCenter() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let critical = CriticalSquare.findCritical(position: position)
        #expect(critical.isEmpty)
    }

    @Test("king on corner row finds squares along that row")
    func kingOnCornerRow() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 5)
            .build()
        let critical = CriticalSquare.findCritical(position: position)
        let hasRowZero = critical.contains { $0.row == 0 }
        #expect(hasRowZero)
    }

    @Test("king on corner column finds squares along that column")
    func kingOnCornerCol() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 0)
            .build()
        let critical = CriticalSquare.findCritical(position: position)
        let hasColZero = critical.contains { $0.col == 0 }
        #expect(hasColZero)
    }

    @Test("no king returns empty")
    func noKingEmpty() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let critical = CriticalSquare.findCritical(position: position)
        #expect(critical.isEmpty)
    }

    @Test("king at corner finds paths to other corners")
    func kingAtCornerEdge() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        let critical = CriticalSquare.findCritical(position: position)
        #expect(!critical.isEmpty)
    }
}
