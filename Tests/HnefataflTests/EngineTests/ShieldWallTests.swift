import Testing
@testable import Hnefatafl

@Suite("Shield Wall Capture Tests")
struct ShieldWallCaptureTests {

    @Test("two defenders against top edge captured by shield wall")
    func twoDefendersOnTopEdge_captured() {
        // Defenders at (0,3) and (0,4) against top edge
        // Attackers backing them at (1,3) and (1,4)
        // Attacker flanking at (0,2), moving attacker to (0,5) to complete wall
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 3)
            .placing(.defender, row: 0, col: 4)
            .placing(.attacker, row: 1, col: 3)
            .placing(.attacker, row: 1, col: 4)
            .placing(.attacker, row: 0, col: 2)
            .placing(.attacker, row: 2, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 2, fromCol: 5, toRow: 0, toCol: 5))

        #expect(afterCapture.pieceAt(row: 0, col: 3) == nil)
        #expect(afterCapture.pieceAt(row: 0, col: 4) == nil)
    }

    @Test("three attackers against top edge captured by shield wall")
    func threeAttackersOnTopEdge_captured() {
        // Attackers at (0,4), (0,5), (0,6) against top edge
        // Defenders backing at (1,4), (1,5), (1,6)
        // Defender at (0,3) already, move defender to (0,7) to complete wall
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 4)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 0, col: 6)
            .placing(.defender, row: 1, col: 4)
            .placing(.defender, row: 1, col: 5)
            .placing(.defender, row: 1, col: 6)
            .placing(.defender, row: 0, col: 3)
            .placing(.defender, row: 2, col: 7)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 2, fromCol: 7, toRow: 0, toCol: 7))

        #expect(afterCapture.pieceAt(row: 0, col: 4) == nil)
        #expect(afterCapture.pieceAt(row: 0, col: 5) == nil)
        #expect(afterCapture.pieceAt(row: 0, col: 6) == nil)
    }

    @Test("incomplete flanking does not capture wall")
    func incompleteFlanking_noCapture() {
        // Defenders at (0,3) and (0,4) but only one backing attacker at (1,3)
        // Missing backer at (1,4) means wall is not complete
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 3)
            .placing(.defender, row: 0, col: 4)
            .placing(.attacker, row: 1, col: 3)
            .placing(.attacker, row: 0, col: 2)
            .placing(.attacker, row: 2, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterMove = position.applyMove(Move(fromRow: 2, fromCol: 5, toRow: 0, toCol: 5))

        #expect(afterMove.pieceAt(row: 0, col: 3) == .defender)
        #expect(afterMove.pieceAt(row: 0, col: 4) == .defender)
    }

    @Test("king in wall is not captured by shield wall rule")
    func kingInWall_notCaptured() {
        // King at (0,4), defender at (0,5) against top edge
        // Attackers backing at (1,4), (1,5) and flanking at (0,3), moving to (0,6)
        let position = emptyBoard()
            .placing(.king, row: 0, col: 4)
            .placing(.defender, row: 0, col: 5)
            .placing(.attacker, row: 1, col: 4)
            .placing(.attacker, row: 1, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 2, col: 6)
            .build()

        let afterMove = position.applyMove(Move(fromRow: 2, fromCol: 6, toRow: 0, toCol: 6))

        #expect(afterMove.pieceAt(row: 0, col: 4) == .king)
        #expect(afterMove.pieceAt(row: 0, col: 5) == .defender)
    }

    @Test("wall on right edge captured")
    func wallOnRightEdge_captured() {
        // Attackers at (3,10) and (4,10) against right edge
        // Defenders backing at (3,9), (4,9) and flanking at (2,10), moving to (5,10)
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 10)
            .placing(.attacker, row: 4, col: 10)
            .placing(.defender, row: 3, col: 9)
            .placing(.defender, row: 4, col: 9)
            .placing(.defender, row: 2, col: 10)
            .placing(.defender, row: 6, col: 10)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 6, fromCol: 10, toRow: 5, toCol: 10))

        #expect(afterCapture.pieceAt(row: 3, col: 10) == nil)
        #expect(afterCapture.pieceAt(row: 4, col: 10) == nil)
    }

    @Test("wall on bottom edge captured")
    func wallOnBottomEdge_captured() {
        let position = emptyBoard()
            .placing(.defender, row: 10, col: 4)
            .placing(.defender, row: 10, col: 5)
            .placing(.attacker, row: 9, col: 4)
            .placing(.attacker, row: 9, col: 5)
            .placing(.attacker, row: 10, col: 3)
            .placing(.attacker, row: 8, col: 6)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 8, fromCol: 6, toRow: 10, toCol: 6))

        #expect(afterCapture.pieceAt(row: 10, col: 4) == nil)
        #expect(afterCapture.pieceAt(row: 10, col: 5) == nil)
    }

    @Test("wall on left edge captured")
    func wallOnLeftEdge_captured() {
        let position = emptyBoard()
            .placing(.attacker, row: 6, col: 0)
            .placing(.attacker, row: 7, col: 0)
            .placing(.defender, row: 6, col: 1)
            .placing(.defender, row: 7, col: 1)
            .placing(.defender, row: 5, col: 0)
            .placing(.defender, row: 9, col: 0)
            .placing(.king, row: 3, col: 3)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 9, fromCol: 0, toRow: 8, toCol: 0))

        #expect(afterCapture.pieceAt(row: 6, col: 0) == nil)
        #expect(afterCapture.pieceAt(row: 7, col: 0) == nil)
    }

    @Test("single piece against edge is not a shield wall")
    func singlePiece_notShieldWall() {
        // Single defender at (0,4) with backer at (1,4) and flankers at (0,3) and (0,5)
        // Even though flanked on both sides along the edge with a backer behind,
        // a single piece is not a shield wall (need 2+ pieces in the row)
        // Note: This IS a custodial capture (sandwiched between 0,3 and 0,5), so
        // we test instead that a single piece with backer but only one flanker survives
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 4)
            .placing(.attacker, row: 1, col: 4)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 3, col: 5)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterMove = position.applyMove(Move(fromRow: 3, fromCol: 5, toRow: 1, toCol: 5))

        #expect(afterMove.pieceAt(row: 0, col: 4) == .defender)
    }

    @Test("corner square counts as flanker in shield wall")
    func cornerCountsAsFlanker() {
        // Attackers at (0,1) and (0,2) against top edge, corner at (0,0) flanks left
        // Defenders back at (1,1), (1,2) and move defender to (0,3) to flank right
        let position = emptyBoard()
            .placing(.attacker, row: 0, col: 1)
            .placing(.attacker, row: 0, col: 2)
            .placing(.defender, row: 1, col: 1)
            .placing(.defender, row: 1, col: 2)
            .placing(.defender, row: 2, col: 3)
            .placing(.king, row: 5, col: 5)
            .build()

        let afterCapture = position.applyMove(Move(fromRow: 2, fromCol: 3, toRow: 0, toCol: 3))

        #expect(afterCapture.pieceAt(row: 0, col: 1) == nil)
        #expect(afterCapture.pieceAt(row: 0, col: 2) == nil)
    }
}
