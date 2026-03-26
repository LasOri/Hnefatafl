import Testing
@testable import Hnefatafl

@Suite("PieceReach Tests")
struct PieceReachTests {

    @Test("king in center has reach")
    func centerKing() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reach = PieceReach.compute(position: pos, row: 5, col: 5)
        #expect(reach > 0)
    }

    @Test("blocked piece has zero reach")
    func blockedPiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.defender, row: 5, col: 6)
            .place(.defender, row: 5, col: 4)
            .place(.defender, row: 4, col: 5)
            .place(.defender, row: 6, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let reach = PieceReach.compute(position: pos, row: 5, col: 5)
        #expect(reach == 0)
    }

    @Test("empty square has zero reach")
    func emptySquare() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reach = PieceReach.compute(position: pos, row: 0, col: 0)
        #expect(reach == 0)
    }

    @Test("corner piece has limited reach")
    func cornerPiece() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 0)
            .build()
        let reach = PieceReach.compute(position: pos, row: 0, col: 0)
        #expect(reach > 0 && reach <= 20)
    }

    @Test("reach is bounded by board")
    func bounded() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reach = PieceReach.compute(position: pos, row: 5, col: 5)
        #expect(reach <= 40)
    }

    @Test("all pieces have reach computed")
    func allPieces() {
        let pos = Position.copenhagenStart()
        let results = PieceReach.computeAll(position: pos)
        #expect(!results.isEmpty)
    }
}
