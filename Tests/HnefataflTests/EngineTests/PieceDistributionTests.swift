import Testing
@testable import Hnefatafl

@Suite("Piece Distribution Tests")
struct PieceDistributionTests {

    @Test("empty board has zero in all halves")
    func emptyBoardZero() {
        let pos = emptyBoard().build()
        #expect(PieceDistribution.topHalf(position: pos, player: .attacker) == 0)
        #expect(PieceDistribution.bottomHalf(position: pos, player: .attacker) == 0)
        #expect(PieceDistribution.leftHalf(position: pos, player: .attacker) == 0)
        #expect(PieceDistribution.rightHalf(position: pos, player: .attacker) == 0)
    }

    @Test("piece in top half counted correctly")
    func topHalfCounted() {
        let pos = emptyBoard()
            .placing(.attacker, row: 2, col: 5)
            .build()
        #expect(PieceDistribution.topHalf(position: pos, player: .attacker) == 1)
        #expect(PieceDistribution.bottomHalf(position: pos, player: .attacker) == 0)
    }

    @Test("piece in bottom half counted correctly")
    func bottomHalfCounted() {
        let pos = emptyBoard()
            .placing(.attacker, row: 8, col: 5)
            .build()
        #expect(PieceDistribution.topHalf(position: pos, player: .attacker) == 0)
        #expect(PieceDistribution.bottomHalf(position: pos, player: .attacker) == 1)
    }

    @Test("left and right halves")
    func leftRightHalves() {
        let pos = emptyBoard()
            .placing(.defender, row: 5, col: 1)
            .placing(.defender, row: 5, col: 9)
            .build()
        #expect(PieceDistribution.leftHalf(position: pos, player: .defender) == 1)
        #expect(PieceDistribution.rightHalf(position: pos, player: .defender) == 1)
    }

    @Test("king counted as defender")
    func kingCountedAsDefender() {
        let pos = emptyBoard()
            .placing(.king, row: 2, col: 2)
            .build()
        #expect(PieceDistribution.topHalf(position: pos, player: .defender) == 1)
        #expect(PieceDistribution.topHalf(position: pos, player: .attacker) == 0)
    }

    @Test("middle row excluded from top and bottom")
    func middleRowExcluded() {
        let pos = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(PieceDistribution.topHalf(position: pos, player: .attacker) == 0)
        #expect(PieceDistribution.bottomHalf(position: pos, player: .attacker) == 0)
    }
}
