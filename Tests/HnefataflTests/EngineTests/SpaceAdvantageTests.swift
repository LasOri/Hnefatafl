import Testing
@testable import Hnefatafl

@Suite("Space Advantage Tests")
struct SpaceAdvantageTests {

    @Test("reachable squares is non-negative")
    func reachableNonNegative() {
        let position = Position.copenhagenStart()
        let result = SpaceAdvantage.reachableSquares(position: position, player: .attacker)
        #expect(result >= 0)
    }

    @Test("empty board with one piece has reachable squares")
    func singlePieceReachable() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[0] = .attacker
        let position = Position(cells: cells)
        let result = SpaceAdvantage.reachableSquares(position: position, player: .attacker)
        #expect(result > 0)
    }

    @Test("advantage is attacker minus defender space")
    func advantageCalculation() {
        let position = Position.copenhagenStart()
        let atkSpace = SpaceAdvantage.reachableSquares(position: position, player: .attacker)
        let defSpace = SpaceAdvantage.reachableSquares(position: position, player: .defender)
        let adv = SpaceAdvantage.advantage(position: position)
        #expect(adv == atkSpace - defSpace)
    }

    @Test("no pieces means zero reachable")
    func noPiecesZeroReachable() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let result = SpaceAdvantage.reachableSquares(position: position, player: .attacker)
        #expect(result == 0)
    }

    @Test("defender reachable includes king moves")
    func defenderIncludesKing() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let result = SpaceAdvantage.reachableSquares(position: position, player: .defender)
        #expect(result > 0)
    }
}
