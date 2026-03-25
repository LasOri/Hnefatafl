import Testing
@testable import Hnefatafl

@Suite("SqueezeDetector Tests")
struct SqueezeDetectorTests {
    @Test("No squeeze on empty board")
    func emptyBoardNoSqueeze() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(SqueezeDetector.squeezeCount(position: position, player: .attacker) == 0)
    }

    @Test("Piece squeezed from all four sides")
    func fullSqueeze() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .placing(.defender, row: 5, col: 6)
            .build()
        let squeezed = SqueezeDetector.squeezedPieces(position: position, player: .attacker)
        #expect(squeezed.count == 1)
        #expect(squeezed[0].row == 5)
        #expect(squeezed[0].col == 5)
    }

    @Test("Squeeze count matches array length")
    func countMatchesArray() {
        let position = Position.copenhagenStart()
        let pieces = SqueezeDetector.squeezedPieces(position: position, player: .attacker)
        let count = SqueezeDetector.squeezeCount(position: position, player: .attacker)
        #expect(count == pieces.count)
    }

    @Test("Corner piece can be squeezed using edges")
    func cornerSqueeze() {
        let position = emptyBoard()
            .placing(.defender, row: 0, col: 0)
            .placing(.attacker, row: 1, col: 0)
            .placing(.attacker, row: 0, col: 1)
            .build()
        let squeezed = SqueezeDetector.squeezedPieces(position: position, player: .defender)
        #expect(squeezed.count == 1)
    }

    @Test("Piece with open side is not squeezed")
    func notSqueezedWithOpenSide() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.defender, row: 6, col: 5)
            .placing(.defender, row: 5, col: 4)
            .build()
        #expect(SqueezeDetector.squeezeCount(position: position, player: .attacker) == 0)
    }

    @Test("Defender squeeze detection")
    func defenderSqueeze() {
        let position = emptyBoard()
            .placing(.defender, row: 5, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .placing(.attacker, row: 6, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        #expect(SqueezeDetector.squeezeCount(position: position, player: .defender) == 1)
    }
}
