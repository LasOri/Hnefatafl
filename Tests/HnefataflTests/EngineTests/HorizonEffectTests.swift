import Testing
@testable import Hnefatafl

@Suite("Horizon Effect Tests")
struct HorizonEffectTests {

    @Test("empty board has zero risk")
    func emptyBoardZeroRisk() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(HorizonEffect.horizonRisk(position: pos) == 0)
    }

    @Test("position with adjacent enemies has positive risk")
    func adjacentEnemiesPositiveRisk() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 6] = .attacker
        cells[3 * 11 + 3] = .king
        let pos = Position(cells: cells)
        #expect(HorizonEffect.horizonRisk(position: pos) > 0)
    }

    @Test("adjacent enemies increase risk")
    func adjacentEnemiesIncrease() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        #expect(HorizonEffect.horizonRisk(position: pos) > 0)
    }

    @Test("no threats means low risk")
    func noThreatsLowRisk() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let risk = HorizonEffect.horizonRisk(position: pos)
        #expect(risk < 5)
    }

    @Test("hasHorizonRisk detects high risk")
    func hasHorizonRiskDetects() {
        let pos = Position.copenhagenStart()
        let result = HorizonEffect.hasHorizonRisk(position: pos)
        let risk = HorizonEffect.horizonRisk(position: pos)
        #expect(result == (risk > 3))
    }

    @Test("king near edge adds risk")
    func kingNearEdgeAddsRisk() {
        var edgeCells: [Piece?] = Array(repeating: nil, count: 121)
        edgeCells[0 * 11 + 5] = .king
        edgeCells[1 * 11 + 5] = .attacker
        let edgePos = Position(cells: edgeCells)

        var centerCells: [Piece?] = Array(repeating: nil, count: 121)
        centerCells[5 * 11 + 5] = .king
        centerCells[4 * 11 + 5] = .attacker
        let centerPos = Position(cells: centerCells)

        #expect(HorizonEffect.horizonRisk(position: edgePos) >= HorizonEffect.horizonRisk(position: centerPos))
    }
}
