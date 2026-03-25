import Testing
@testable import Hnefatafl

@Suite("SkeweredPieceDetector Tests")
struct SkeweredPieceDetectorTests {

    @Test("empty board has no skewered pieces")
    func emptyBoardNoSkewers() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let skewered = SkeweredPieceDetector.skeweredPieces(position: pos, player: .attacker)
        #expect(skewered.isEmpty)
    }

    @Test("skewer count matches skewered pieces count")
    func countMatchesList() {
        let pos = Position.copenhagenStart()
        let list = SkeweredPieceDetector.skeweredPieces(position: pos, player: .defender)
        let count = SkeweredPieceDetector.skewerCount(position: pos, player: .defender)
        #expect(count == list.count)
    }

    @Test("single piece cannot be skewered")
    func singlePieceNotSkewered() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let count = SkeweredPieceDetector.skewerCount(position: pos, player: .attacker)
        #expect(count == 0)
    }

    @Test("lone king not skewered with no opponents")
    func loneKingNotSkewered() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let count = SkeweredPieceDetector.skewerCount(position: pos, player: .defender)
        #expect(count == 0)
    }

    @Test("skewer count is non-negative on start position")
    func startPositionNonNegative() {
        let pos = Position.copenhagenStart()
        let count = SkeweredPieceDetector.skewerCount(position: pos, player: .attacker)
        #expect(count >= 0)
    }

    @Test("skewered pieces returns valid board coordinates")
    func validCoordinates() {
        let pos = Position.copenhagenStart()
        let skewered = SkeweredPieceDetector.skeweredPieces(position: pos, player: .defender)
        for sq in skewered {
            #expect(sq.row >= 0 && sq.row < Position.boardSize)
            #expect(sq.col >= 0 && sq.col < Position.boardSize)
        }
    }
}
