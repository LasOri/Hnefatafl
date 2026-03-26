import Testing
@testable import Hnefatafl

@Suite("PositionReachability Tests")
struct PositionReachabilityTests {

    @Test("piece at center can reach many squares in 1 move")
    func centerReach() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reachable = PositionReachability.reachable(from: (5, 5), position: pos, maxMoves: 1)
        #expect(!reachable.isEmpty)
    }

    @Test("blocked piece has limited reach")
    func blockedPiece() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.defender, row: 5, col: 6)
            .place(.defender, row: 5, col: 4)
            .place(.defender, row: 4, col: 5)
            .place(.defender, row: 6, col: 5)
            .place(.king, row: 0, col: 0)
            .build()
        let reachable = PositionReachability.reachable(from: (5, 5), position: pos, maxMoves: 1)
        #expect(reachable.isEmpty)
    }

    @Test("empty square returns empty")
    func emptySquare() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reachable = PositionReachability.reachable(from: (0, 0), position: pos, maxMoves: 1)
        #expect(reachable.isEmpty)
    }

    @Test("reachable in 0 moves is empty")
    func zeroMoves() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reachable = PositionReachability.reachable(from: (5, 5), position: pos, maxMoves: 0)
        #expect(reachable.isEmpty)
    }

    @Test("reachable squares are valid coordinates")
    func validCoordinates() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let reachable = PositionReachability.reachable(from: (5, 5), position: pos, maxMoves: 1)
        for sq in reachable {
            #expect(sq.0 >= 0 && sq.0 < 11)
            #expect(sq.1 >= 0 && sq.1 < 11)
        }
    }

    @Test("corner piece has limited reach directions")
    func cornerPiece() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 0)
            .build()
        let reachable = PositionReachability.reachable(from: (0, 0), position: pos, maxMoves: 1)
        #expect(!reachable.isEmpty)
    }
}
