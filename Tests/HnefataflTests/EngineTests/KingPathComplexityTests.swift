import Testing
@testable import Hnefatafl

@Suite("King Path Complexity Tests")
struct KingPathComplexityTests {

    @Test("empty board king has direct path to corner")
    func emptyBoardDirectPath() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 5)
            .build()
        #expect(KingPathComplexity.hasDirectPath(position: pos))
    }

    @Test("blocked king has no direct path")
    func blockedKingNoDirectPath() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 3)
            .placing(.attacker, row: 5, col: 7)
            .placing(.attacker, row: 3, col: 5)
            .placing(.attacker, row: 7, col: 5)
            .build()
        #expect(!KingPathComplexity.hasDirectPath(position: pos))
    }

    @Test("no king returns zero complexity")
    func noKingZeroComplexity() {
        let pos = emptyBoard().build()
        #expect(KingPathComplexity.complexity(position: pos) == 0)
    }

    @Test("king at corner has zero complexity")
    func kingAtCornerZero() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .build()
        #expect(KingPathComplexity.complexity(position: pos) == 0)
    }

    @Test("king on edge row has low complexity")
    func kingOnEdgeRowLow() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 3)
            .build()
        let c = KingPathComplexity.complexity(position: pos)
        #expect(c <= 1)
    }

    @Test("no king returns false for hasDirectPath")
    func noKingFalseDirectPath() {
        let pos = emptyBoard().build()
        #expect(!KingPathComplexity.hasDirectPath(position: pos))
    }

    @Test("king on corner row with clear path")
    func kingOnCornerRow() {
        let pos = emptyBoard()
            .placing(.king, row: 0, col: 2)
            .build()
        #expect(KingPathComplexity.hasDirectPath(position: pos))
    }
}
