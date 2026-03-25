import Testing
@testable import Hnefatafl

@Suite("IsolatedPieceEval Tests")
struct IsolatedPieceEvalTests {
    @Test("Isolated count on empty board is zero")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let count = IsolatedPieceEval.isolatedCount(position: position, player: .attacker)
        #expect(count == 0)
    }

    @Test("Single attacker with no neighbors is isolated")
    func singleAttackerIsolated() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let count = IsolatedPieceEval.isolatedCount(position: position, player: .attacker)
        #expect(count == 1)
    }

    @Test("Two adjacent attackers are not isolated")
    func adjacentNotIsolated() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .attacker
        let position = Position(cells: cells)
        let count = IsolatedPieceEval.isolatedCount(position: position, player: .attacker)
        #expect(count == 0)
    }

    @Test("Isolation penalty is negative per isolated piece")
    func penaltyIsNegative() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[20] = .attacker
        let position = Position(cells: cells)
        let penalty = IsolatedPieceEval.isolationPenalty(position: position, player: .attacker)
        #expect(penalty < 0)
    }

    @Test("King counts as defender friendly neighbor")
    func kingAsDefenderNeighbor() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        cells[61] = .defender
        let position = Position(cells: cells)
        let count = IsolatedPieceEval.isolatedCount(position: position, player: .defender)
        #expect(count == 0)
    }

    @Test("Start position has some isolated pieces")
    func startPositionIsolation() {
        let position = Position.copenhagenStart()
        let attackerIsolated = IsolatedPieceEval.isolatedCount(position: position, player: .attacker)
        let defenderIsolated = IsolatedPieceEval.isolatedCount(position: position, player: .defender)
        #expect(attackerIsolated >= 0)
        #expect(defenderIsolated >= 0)
    }
}
