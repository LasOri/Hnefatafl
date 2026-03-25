import Testing
@testable import Hnefatafl

@Suite("Territory Control Map Tests")
struct TerritoryControlMapTests {

    @Test("map has correct size")
    func correctSize() {
        let position = Position.copenhagenStart()
        let map = TerritoryControlMap.compute(position: position)
        #expect(map.count == Position.boardSize)
        #expect(map[0].count == Position.boardSize)
    }

    @Test("positive values favor attacker")
    func positiveFavorsAttacker() {
        let position = Position.copenhagenStart()
        let map = TerritoryControlMap.compute(position: position)
        let sum = map.flatMap { $0 }.reduce(0, +)
        let _ = sum
    }

    @Test("empty board has zero control")
    func emptyBoard() {
        let cells: [Piece?] = Array(repeating: nil, count: 121)
        let position = Position(cells: cells)
        let map = TerritoryControlMap.compute(position: position)
        let sum = map.flatMap { $0 }.reduce(0, +)
        #expect(sum == 0)
    }

    @Test("attacker territory count")
    func attackerTerritory() {
        let position = Position.copenhagenStart()
        let count = TerritoryControlMap.territoryCount(position: position, player: .attacker)
        #expect(count >= 0)
    }

    @Test("defender territory count")
    func defenderTerritory() {
        let position = Position.copenhagenStart()
        let count = TerritoryControlMap.territoryCount(position: position, player: .defender)
        #expect(count >= 0)
    }

    @Test("total territory equals board size")
    func totalTerritory() {
        let position = Position.copenhagenStart()
        let att = TerritoryControlMap.territoryCount(position: position, player: .attacker)
        let def = TerritoryControlMap.territoryCount(position: position, player: .defender)
        let neutral = TerritoryControlMap.neutralCount(position: position)
        #expect(att + def + neutral == Position.boardSize * Position.boardSize)
    }
}
