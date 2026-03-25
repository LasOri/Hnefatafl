import Testing
@testable import Hnefatafl

@Suite("Piece Density Map Tests")
struct PieceDensityMapTests {

    @Test("empty board has zero density")
    func emptyBoardZeroDensity() {
        let pos = emptyBoard().build()
        let d = PieceDensityMap.density(position: pos, centerRow: 5, centerCol: 5, radius: 3)
        #expect(d == 0)
    }

    @Test("single piece within radius counted")
    func singlePieceWithinRadius() {
        let pos = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let d = PieceDensityMap.density(position: pos, centerRow: 5, centerCol: 5, radius: 0)
        #expect(d == 1)
    }

    @Test("piece outside radius not counted")
    func pieceOutsideRadius() {
        let pos = emptyBoard()
            .placing(.attacker, row: 0, col: 0)
            .build()
        let d = PieceDensityMap.density(position: pos, centerRow: 5, centerCol: 5, radius: 2)
        #expect(d == 0)
    }

    @Test("multiple pieces within radius")
    func multiplePiecesWithinRadius() {
        let pos = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .placing(.king, row: 6, col: 5)
            .build()
        let d = PieceDensityMap.density(position: pos, centerRow: 5, centerCol: 5, radius: 1)
        #expect(d == 3)
    }

    @Test("high density zones on empty board is empty")
    func emptyBoardNoHighDensity() {
        let pos = emptyBoard().build()
        let zones = PieceDensityMap.highDensityZones(position: pos, threshold: 1)
        #expect(zones.isEmpty)
    }

    @Test("high density zones returns zones above threshold")
    func highDensityAboveThreshold() {
        let pos = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 6, col: 5)
            .build()
        let zones = PieceDensityMap.highDensityZones(position: pos, threshold: 3)
        #expect(!zones.isEmpty)
    }
}
