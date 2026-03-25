import Testing
@testable import Hnefatafl

@Suite("Influence Map Tests")
struct InfluenceMapTests {

    @Test("empty board produces zero influence")
    func emptyBoardZeroInfluence() {
        let position = emptyBoard().placing(.king, row: 5, col: 5).build()
        let map = InfluenceMapBuilder.build(position: position, player: .attacker)
        #expect(map.totalInfluence == 0)
    }

    @Test("single attacker radiates influence")
    func singleAttackerInfluence() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let map = InfluenceMapBuilder.build(position: position, player: .attacker)
        #expect(map.totalInfluence > 0)
    }

    @Test("value at specific cell returns correct influence")
    func valueAtCell() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let map = InfluenceMapBuilder.build(position: position, player: .attacker)
        let adjacent = map.value(row: 5, col: 6)
        #expect(adjacent == 3)
    }

    @Test("influence blocked by pieces")
    func influenceBlockedByPiece() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 5)
            .placing(.defender, row: 5, col: 6)
            .build()
        let map = InfluenceMapBuilder.build(position: position, player: .attacker)
        let blocked = map.value(row: 5, col: 7)
        #expect(blocked == 0)
    }

    @Test("influence map equality")
    func influenceMapEquality() {
        let position = Position.copenhagenStart()
        let map1 = InfluenceMapBuilder.build(position: position, player: .attacker)
        let map2 = InfluenceMapBuilder.build(position: position, player: .attacker)
        #expect(map1 == map2)
    }
}
