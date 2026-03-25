import Testing
@testable import Hnefatafl

@Suite("PieceHeatmap Tests")
struct PieceHeatmapTests {

    @Test("empty board has zero heat everywhere")
    func emptyBoardZeroHeat() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceHeatmap.heatValue(row: 5, col: 5, position: position) == 0)
    }

    @Test("single piece has heat at its own square")
    func singlePieceHeatAtOwnSquare() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        #expect(PieceHeatmap.heatValue(row: 5, col: 5, position: position) >= 1)
    }

    @Test("heat decreases with distance")
    func heatDecreasesWithDistance() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .build()
        let nearHeat = PieceHeatmap.heatValue(row: 5, col: 6, position: position)
        let farHeat = PieceHeatmap.heatValue(row: 5, col: 9, position: position)
        #expect(nearHeat >= farHeat)
    }

    @Test("maxHeat is zero on empty board")
    func maxHeatEmptyBoard() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(PieceHeatmap.maxHeat(position: position) == 0)
    }

    @Test("maxHeat is positive on start position")
    func maxHeatPositiveOnStart() {
        let position = Position.copenhagenStart()
        #expect(PieceHeatmap.maxHeat(position: position) > 0)
    }

    @Test("heat value is non-negative")
    func heatValueNonNegative() {
        let position = Position.copenhagenStart()
        for row in 0..<Position.boardSize {
            for col in 0..<Position.boardSize {
                #expect(PieceHeatmap.heatValue(row: row, col: col, position: position) >= 0)
            }
        }
    }

    @Test("maxHeat at least equals any individual heat value")
    func maxHeatIsMaximum() {
        let position = Position.copenhagenStart()
        let maxVal = PieceHeatmap.maxHeat(position: position)
        let sampleHeat = PieceHeatmap.heatValue(row: 5, col: 5, position: position)
        #expect(maxVal >= sampleHeat)
    }
}
