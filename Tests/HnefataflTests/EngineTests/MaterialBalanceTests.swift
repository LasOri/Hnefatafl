import Testing
@testable import Hnefatafl

@Suite("Material Balance Tests")
struct MaterialBalanceTests {

    @Test("start position balance is attacker heavy")
    func startPositionBalance() {
        let pos = Position.copenhagenStart()
        let bal = MaterialBalance.balance(position: pos)
        #expect(bal > 0)
    }

    @Test("normalized balance between -1 and 1")
    func normalizedBetweenNeg1And1() {
        let pos = Position.copenhagenStart()
        let norm = MaterialBalance.normalizedBalance(position: pos)
        #expect(norm >= -1.0)
        #expect(norm <= 1.0)
    }

    @Test("start position is balanced within default threshold")
    func balancedAtStart() {
        let pos = Position.copenhagenStart()
        let isBalanced = MaterialBalance.isBalanced(position: pos)
        let bal = MaterialBalance.balance(position: pos)
        #expect(isBalanced == (abs(bal) <= 3))
    }

    @Test("empty board is balanced")
    func emptyIsBalanced() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(MaterialBalance.isBalanced(position: pos))
        #expect(MaterialBalance.normalizedBalance(position: pos) == 0)
    }

    @Test("advantage returns nil when balanced")
    func advantageNilWhenBalanced() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[1] = .defender
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(MaterialBalance.advantage(position: pos) == nil)
    }

    @Test("attacker advantage when more attackers")
    func attackerAdvantage() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        for i in 0..<8 { cells[i] = .attacker }
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        #expect(MaterialBalance.advantage(position: pos) == .attacker)
    }
}
