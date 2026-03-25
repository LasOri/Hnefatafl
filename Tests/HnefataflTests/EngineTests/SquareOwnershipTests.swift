import Testing
@testable import Hnefatafl

@Suite("SquareOwnership Tests")
struct SquareOwnershipTests {

    @Test("occupied square has no owner")
    func occupiedSquareNoOwner() {
        let pos = Position.copenhagenStart()
        let owner = SquareOwnership.owner(row: 5, col: 5, position: pos)
        #expect(owner == nil)
    }

    @Test("square near lone attacker owned by attacker")
    func nearAttacker() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let owner = SquareOwnership.owner(row: 0, col: 1, position: pos)
        #expect(owner == .attacker)
    }

    @Test("square near lone defender owned by defender")
    func nearDefender() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        let owner = SquareOwnership.owner(row: 5, col: 6, position: pos)
        #expect(owner == .defender)
    }

    @Test("equidistant square is unowned")
    func equidistantUnowned() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[0 * 11 + 10] = .defender
        let pos = Position(cells: cells)
        let owner = SquareOwnership.owner(row: 0, col: 5, position: pos)
        #expect(owner == nil)
    }

    @Test("owned square count is nonzero for start position")
    func ownedCountNonzero() {
        let pos = Position.copenhagenStart()
        let attackerOwned = SquareOwnership.ownedSquareCount(position: pos, player: .attacker)
        #expect(attackerOwned > 0)
    }

    @Test("out of bounds returns nil")
    func outOfBoundsNil() {
        let pos = Position.copenhagenStart()
        let owner = SquareOwnership.owner(row: -1, col: 0, position: pos)
        #expect(owner == nil)
    }
}
