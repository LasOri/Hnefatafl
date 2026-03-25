import Testing
@testable import Hnefatafl

@Suite("Adjacent Piece Count Tests")
struct AdjacentPieceCountTests {

    @Test("start position has nonzero average adjacency")
    func startPositionNonZero() {
        let pos = Position.copenhagenStart()
        let avg = AdjacentPieceCount.averageAdjacency(position: pos, player: .defender)
        #expect(avg > 0)
    }

    @Test("empty board returns zero average adjacency")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let avg = AdjacentPieceCount.averageAdjacency(position: pos, player: .attacker)
        #expect(avg == 0)
    }

    @Test("isolated piece has zero adjacency")
    func isolatedPiece() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(AdjacentPieceCount.maxAdjacency(position: pos, player: .attacker) == 0)
    }

    @Test("two adjacent pieces each have adjacency 1")
    func twoAdjacentPieces() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let avg = AdjacentPieceCount.averageAdjacency(position: pos, player: .attacker)
        #expect(avg > 0)
    }

    @Test("maxAdjacency returns highest count")
    func maxAdjacencyHighest() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .defender
        cells[5 * 11 + 6] = .defender
        cells[4 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        #expect(AdjacentPieceCount.maxAdjacency(position: pos, player: .attacker) == 3)
    }

    @Test("king counts for defender adjacency")
    func kingCountsForDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let avg = AdjacentPieceCount.averageAdjacency(position: pos, player: .defender)
        #expect(avg > 0)
    }
}
