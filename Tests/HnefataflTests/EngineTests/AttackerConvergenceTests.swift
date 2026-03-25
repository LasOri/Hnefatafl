import Testing
@testable import Hnefatafl

@Suite("Attacker Convergence Tests")
struct AttackerConvergenceTests {

    @Test("no king returns zero convergence")
    func noKingZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(AttackerConvergence.convergenceScore(position: pos) == 0)
    }

    @Test("no attackers returns zero convergence")
    func noAttackersZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(AttackerConvergence.convergenceScore(position: pos) == 0)
    }

    @Test("nearby attackers give higher convergence")
    func nearbyHigherScore() {
        var nearCells: [Piece?] = Array(repeating: nil, count: 121)
        nearCells[5 * 11 + 5] = .king
        nearCells[5 * 11 + 6] = .attacker
        nearCells[4 * 11 + 5] = .attacker
        let nearPos = Position(cells: nearCells)

        var farCells: [Piece?] = Array(repeating: nil, count: 121)
        farCells[5 * 11 + 5] = .king
        farCells[0] = .attacker
        farCells[10] = .attacker
        let farPos = Position(cells: farCells)

        #expect(AttackerConvergence.convergenceScore(position: nearPos) > AttackerConvergence.convergenceScore(position: farPos))
    }

    @Test("nearby attackers count within radius")
    func nearbyAttackersInRadius() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 6] = .attacker
        cells[4 * 11 + 5] = .attacker
        cells[0] = .attacker
        let pos = Position(cells: cells)
        #expect(AttackerConvergence.nearbyAttackers(position: pos, radius: 2) == 2)
    }

    @Test("radius zero returns only adjacent attackers")
    func radiusZeroNone() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[5 * 11 + 7] = .attacker
        let pos = Position(cells: cells)
        #expect(AttackerConvergence.nearbyAttackers(position: pos, radius: 0) == 0)
    }

    @Test("start position has positive convergence")
    func startPositionPositive() {
        let pos = Position.copenhagenStart()
        #expect(AttackerConvergence.convergenceScore(position: pos) > 0)
    }
}
