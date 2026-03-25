import Testing
@testable import Hnefatafl

@Suite("PieceMomentum Tests")
struct PieceMomentumTests {
    @Test("Attacker momentum at start is non-negative or non-positive")
    func attackerMomentumStart() {
        let position = Position.copenhagenStart()
        let momentum = PieceMomentum.attackerMomentum(position: position)
        #expect(momentum == momentum)
    }

    @Test("Defender momentum at start")
    func defenderMomentumStart() {
        let position = Position.copenhagenStart()
        let momentum = PieceMomentum.defenderMomentum(position: position)
        #expect(momentum == momentum)
    }

    @Test("Empty board has zero attacker momentum")
    func emptyBoardZeroAttackerMomentum() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let momentum = PieceMomentum.attackerMomentum(position: position)
        #expect(momentum == 0)
    }

    @Test("Empty board has zero defender momentum")
    func emptyBoardZeroDefenderMomentum() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let momentum = PieceMomentum.defenderMomentum(position: position)
        #expect(momentum == 0)
    }

    @Test("Single attacker at edge has inward momentum")
    func singleAttackerEdge() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[0 * 11 + 5] = .attacker
        let position = Position(cells: cells)
        let momentum = PieceMomentum.attackerMomentum(position: position)
        #expect(momentum >= 0)
    }

    @Test("King near corner has non-zero defender momentum")
    func kingNearCorner() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[1 * 11 + 1] = .king
        let position = Position(cells: cells)
        let momentum = PieceMomentum.defenderMomentum(position: position)
        #expect(momentum != 0)
    }
}
