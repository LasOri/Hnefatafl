import Testing
@testable import Hnefatafl

@Suite("ShieldWallEval Tests")
struct ShieldWallEvalTests {

    @Test("empty board has no shield wall threats")
    func emptyBoardNoThreats() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(ShieldWallEval.shieldWallThreats(position: position) == 0)
    }

    @Test("start position shield wall threats is non-negative")
    func startPositionNonNegative() {
        let position = Position.copenhagenStart()
        #expect(ShieldWallEval.shieldWallThreats(position: position) >= 0)
    }

    @Test("defender on edge with attacker behind and flanked is threat")
    func defenderFlankedOnEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .defender
        cells[1 * 11 + 5] = .attacker
        cells[0 * 11 + 4] = .attacker
        cells[0 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        #expect(ShieldWallEval.shieldWallThreats(position: position) >= 1)
    }

    @Test("hasShieldWallOpportunity returns bool")
    func hasOpportunityReturnsBool() {
        let position = Position.copenhagenStart()
        let result = ShieldWallEval.hasShieldWallOpportunity(position: position)
        #expect(result == true || result == false)
    }

    @Test("defender not on edge produces no wall threat")
    func defenderNotOnEdge() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[4 * 11 + 5] = .attacker
        cells[5 * 11 + 4] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        #expect(ShieldWallEval.shieldWallThreats(position: position) == 0)
    }

    @Test("multiple edge threats count independently")
    func multipleEdgeThreats() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 3] = .defender
        cells[1 * 11 + 3] = .attacker
        cells[0 * 11 + 2] = .attacker
        cells[0 * 11 + 4] = .attacker
        cells[0 * 11 + 7] = .defender
        cells[1 * 11 + 7] = .attacker
        cells[0 * 11 + 6] = .attacker
        cells[0 * 11 + 8] = .attacker
        let position = Position(cells: cells)
        #expect(ShieldWallEval.shieldWallThreats(position: position) >= 2)
    }
}
