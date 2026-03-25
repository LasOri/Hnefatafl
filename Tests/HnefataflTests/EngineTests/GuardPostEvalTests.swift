import Testing
@testable import Hnefatafl

@Suite("GuardPostEval Tests")
struct GuardPostEvalTests {
    @Test("Guarded squares at Copenhagen start")
    func guardedSquaresStart() {
        let position = Position.copenhagenStart()
        let count = GuardPostEval.guardedSquares(position: position)
        #expect(count >= 0)
        #expect(count <= 4)
    }

    @Test("Guard quality at Copenhagen start")
    func guardQualityStart() {
        let position = Position.copenhagenStart()
        let quality = GuardPostEval.guardQuality(position: position)
        #expect(quality >= 0)
    }

    @Test("King surrounded by four defenders")
    func fourGuards() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .build()
        let count = GuardPostEval.guardedSquares(position: position)
        #expect(count == 4)
    }

    @Test("No king returns zero")
    func noKing() {
        let position = emptyBoard()
            .placing(.defender, row: 3, col: 3)
            .build()
        #expect(GuardPostEval.guardedSquares(position: position) == 0)
        #expect(GuardPostEval.guardQuality(position: position) == 0)
    }

    @Test("Single guard returns one guarded square")
    func singleGuard() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .build()
        #expect(GuardPostEval.guardedSquares(position: position) == 1)
    }

    @Test("Guard quality higher with supporting defenders")
    func supportingDefenders() {
        let withSupport = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 3, col: 5)
            .build()
        let withoutSupport = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .build()
        let qualityWithSupport = GuardPostEval.guardQuality(position: withSupport)
        let qualityWithout = GuardPostEval.guardQuality(position: withoutSupport)
        #expect(qualityWithSupport > qualityWithout)
    }

    @Test("Attackers adjacent to king do not count as guards")
    func attackersNotGuards() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .build()
        #expect(GuardPostEval.guardedSquares(position: position) == 0)
    }
}
