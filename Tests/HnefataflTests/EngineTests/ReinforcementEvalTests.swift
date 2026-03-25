import Testing
@testable import Hnefatafl

@Suite("Reinforcement Eval Tests")
struct ReinforcementEvalTests {

    @Test("empty board has zero reinforcement potential")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(ReinforcementEval.reinforcementPotential(position: pos, player: .attacker) == 0)
    }

    @Test("start position attackers have positive potential")
    func startPositionAttackers() {
        let pos = Position.copenhagenStart()
        let potential = ReinforcementEval.reinforcementPotential(position: pos, player: .attacker)
        #expect(potential > 0)
    }

    @Test("nearest reinforcement finds adjacent piece")
    func nearestAdjacentPiece() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let pos = Position(cells: cells)
        let distance = ReinforcementEval.nearestReinforcement(row: 5, col: 5, position: pos, player: .attacker)
        #expect(distance == 1)
    }

    @Test("no friendly pieces returns nil distance")
    func noFriendlyNil() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        let pos = Position(cells: cells)
        let distance = ReinforcementEval.nearestReinforcement(row: 5, col: 5, position: pos, player: .attacker)
        #expect(distance == nil)
    }

    @Test("king counts as defender reinforcement")
    func kingAsDefenderReinforcement() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        cells[5 * 11 + 8] = .king
        let pos = Position(cells: cells)
        let distance = ReinforcementEval.nearestReinforcement(row: 5, col: 5, position: pos, player: .defender)
        #expect(distance == 3)
    }

    @Test("enemy pieces not counted as reinforcement")
    func enemyNotCounted() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .defender
        let pos = Position(cells: cells)
        let distance = ReinforcementEval.nearestReinforcement(row: 5, col: 5, position: pos, player: .attacker)
        #expect(distance == nil)
    }

    @Test("defender reinforcement potential includes king moves")
    func defenderPotentialPositive() {
        let pos = Position.copenhagenStart()
        let potential = ReinforcementEval.reinforcementPotential(position: pos, player: .defender)
        #expect(potential > 0)
    }
}
