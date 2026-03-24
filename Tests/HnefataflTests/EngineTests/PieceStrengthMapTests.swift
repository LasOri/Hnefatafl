import Testing
@testable import Hnefatafl

@Suite("Piece Strength Map Tests")
struct PieceStrengthMapTests {

    @Test("strength map has 121 entries")
    func entryCount() {
        let position = Position.copenhagenStart()
        let map = PieceStrengthMap.compute(position: position)
        #expect(map.count == 121)
    }

    @Test("empty square has zero strength")
    func emptySquare() {
        let position = Position.copenhagenStart()
        let map = PieceStrengthMap.compute(position: position)
        #expect(map[0] == 0)
    }

    @Test("piece with more moves has higher strength")
    func moreMovesHigherStrength() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[0] = .attacker
        let position = Position(cells: cells)
        let map = PieceStrengthMap.compute(position: position)
        let centerStrength = map[5 * 11 + 5]
        let cornerStrength = map[0]
        #expect(centerStrength > cornerStrength)
    }

    @Test("king has bonus strength")
    func kingBonus() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[60] = .king
        cells[61] = .defender
        let position = Position(cells: cells)
        let map = PieceStrengthMap.compute(position: position)
        #expect(map[60] > map[61])
    }

    @Test("empty board all zeros")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let map = PieceStrengthMap.compute(position: position)
        #expect(map.allSatisfy { $0 == 0 })
    }

    @Test("total strength sums all values")
    func totalStrength() {
        let position = Position.copenhagenStart()
        let map = PieceStrengthMap.compute(position: position)
        let total = PieceStrengthMap.totalStrength(map: map)
        #expect(total > 0)
    }

    @Test("attacker total strength")
    func attackerStrength() {
        let position = Position.copenhagenStart()
        let strength = PieceStrengthMap.sideStrength(position: position, side: .attacker)
        #expect(strength > 0)
    }

    @Test("defender total strength")
    func defenderStrength() {
        let position = Position.copenhagenStart()
        let strength = PieceStrengthMap.sideStrength(position: position, side: .defender)
        #expect(strength > 0)
    }
}
