import Testing
@testable import Hnefatafl

@Suite("AttackSurface Tests")
struct AttackSurfaceTests {
    @Test("Surface area at start is non-negative")
    func surfaceAreaStart() {
        let position = Position.copenhagenStart()
        let area = AttackSurface.surfaceArea(position: position)
        #expect(area >= 0)
    }

    @Test("Empty board has zero surface area")
    func emptyBoardZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let area = AttackSurface.surfaceArea(position: position)
        #expect(area == 0)
    }

    @Test("Surface balance at start")
    func surfaceBalanceStart() {
        let position = Position.copenhagenStart()
        let balance = AttackSurface.surfaceBalance(position: position)
        #expect(balance == balance)
    }

    @Test("Empty board has zero surface balance")
    func emptyBoardZeroBalance() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let balance = AttackSurface.surfaceBalance(position: position)
        #expect(balance == 0)
    }

    @Test("Adjacent attacker and defender form surface")
    func adjacentPiecesSurface() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .defender
        let position = Position(cells: cells)
        let area = AttackSurface.surfaceArea(position: position)
        #expect(area == 1)
    }

    @Test("Non-adjacent pieces have zero surface")
    func nonAdjacentZeroSurface() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[10 * 11 + 10] = .defender
        let position = Position(cells: cells)
        let area = AttackSurface.surfaceArea(position: position)
        #expect(area == 0)
    }
}
